{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          jdk21
          nodejs_20
          nodePackages."@angular/cli"
          mariadb
          mariadb-client
          tomcat10
          apacheHttpd
          git
          curl
          gnused
        ];

        shellHook = ''
          echo "🚀 Avvio ambiente Portale Commesse..."
          
          # 1. Ferma servizi precedenti
          echo "🛑 Fermo servizi precedenti..."
          killall mysqld 2>/dev/null || true
          ${pkgs.tomcat10}/bin/catalina.sh stop 2>/dev/null || true
          sleep 2
          
          # 2. Setup MariaDB
          echo "🗄️  Configuro MariaDB..."
          MYSQL_DIR="/tmp/commesse-mysql"
          mkdir -p "$MYSQL_DIR/data"
          
          # Inizializza DB se vuoto
          if [ ! -f "$MYSQL_DIR/data/ibdata1" ]; then
            mysql_install_db \
              --auth-root-authentication-method=normal \
              --datadir="$MYSQL_DIR/data" \
              --basedir=${pkgs.mariadb}
          fi
          
          # Avvia MariaDB
          mysqld_safe \
            --datadir="$MYSQL_DIR/data" \
            --socket="$MYSQL_DIR/mysql.sock" \
            --port=3307 \
            --pid-file="$MYSQL_DIR/mysql.pid" \
            --log-error="$MYSQL_DIR/mysql.log" &
          
          # Attendi avvio
          echo "⏳ Attendo avvio MariaDB..."
          sleep 8
          
          # 3. Configura database e utenti
          echo "🔧 Configuro database..."
          
          # Crea utente root temporaneo
          mysqladmin --host=127.0.0.1 --port=3307 --user=root password '' 2>/dev/null || true
          
          mysql --host=127.0.0.1 --port=3307 --user=root --password= <<EOF
          CREATE DATABASE IF NOT EXISTS gestione_commesse;
          CREATE USER IF NOT EXISTS 'commesse'@'localhost' IDENTIFIED BY 'commesse';
          CREATE USER IF NOT EXISTS 'commesse'@'127.0.0.1' IDENTIFIED BY 'commesse';
          GRANT ALL PRIVILEGES ON gestione_commesse.* TO 'commesse'@'localhost';
          GRANT ALL PRIVILEGES ON gestione_commesse.* TO 'commesse'@'127.0.0.1';
          FLUSH PRIVILEGES;
          EOF
          
          # 4. Importa dump SQL SE ESISTE
          echo "📥 Cerco dump SQL..."
          if [ -f "db/gestione_commesse.sql" ]; then
            echo "✅ Trovato: db/gestione_commesse.sql"
            echo "📊 Righe: $(wc -l < db/gestione_commesse.sql)"
            
            # Importa con verbose
            echo "Importazione in corso..."
            mysql --host=127.0.0.1 --port=3307 --user=commesse --password=commesse gestione_commesse < db/gestione_commesse.sql 2>&1 | head -20
            
            # Conta tabelle importate
            TABLES=$(mysql --host=127.0.0.1 --port=3307 --user=commesse --password=commesse gestione_commesse -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'gestione_commesse';" 2>/dev/null || echo "0")
            echo "✅ Importate $TABLES tabelle"
          else
            echo "❌ File non trovato: db/gestione_commesse.sql"
            echo "   Crea il file o controlla il percorso"
            echo "   Per creare: mkdir -p db && cp /tuo/file.sql db/gestione_commesse.sql"
          fi
          
          # 5. Avvia Tomcat
          echo "🐈 Avvio Tomcat..."
          TOMCAT_DIR="/tmp/commesse-tomcat"
          mkdir -p "$TOMCAT_DIR"/{webapps,logs,temp,work}
          
          if [ -f "deploy/app.war" ]; then
            cp deploy/app.war "$TOMCAT_DIR/webapps/ROOT.war"
          else
            # Crea WAR vuoto per test
            touch "$TOMCAT_DIR/webapps/ROOT.war"
          fi
          
          export CATALINA_HOME=${pkgs.tomcat10}
          export CATALINA_BASE="$TOMCAT_DIR"
          ${pkgs.tomcat10}/bin/catalina.sh start > "$TOMCAT_DIR/logs/catalina.out" 2>&1 &
          sleep 3
          
          # 6. Info finali
          echo ""
          echo "✅ AMBIENTE PRONTO"
          echo "=================="
          echo "📦 Database:"
          echo "   mysql -h 127.0.0.1 -P 3307 -u commesse -pcommesse gestione_commesse"
          echo ""
          echo "📊 Stato database:"
          mysql --host=127.0.0.1 --port=3307 --user=commesse --password=commesse gestione_commesse -e "SHOW TABLES;" 2>/dev/null || echo "   ⚠️  Nessuna tabella trovata"
          echo ""
          echo "🌐 Tomcat: http://localhost:8080"
          echo "   Logs: $TOMCAT_DIR/logs/catalina.out"
          echo ""
          echo "🛑 Per fermare: pkill -f mysqld ; ${pkgs.tomcat10}/bin/catalina.sh stop"
          echo ""
        '';
      };
    };
}
