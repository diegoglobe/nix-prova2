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
          
          PROJECT_DIR="$PWD"
          echo "📁 Directory progetto: $PROJECT_DIR"
          
          # 1. Ferma servizi precedenti
          echo "🛑 Fermo servizi precedenti..."
          killall mysqld 2>/dev/null || true
          
          # Ferma Tomcat se già in esecuzione
          if [ -f "$PROJECT_DIR/tomcat10/bin/catalina.sh" ]; then
            "$PROJECT_DIR/tomcat10/bin/catalina.sh" stop 2>/dev/null || true
          fi
          sleep 2
          
          # 2. Setup MariaDB
          echo "🗄️  Configuro MariaDB..."
          MYSQL_DIR="$PROJECT_DIR/mysql-data"
          mkdir -p "$MYSQL_DIR/data"
          
          # Inizializza DB se vuoto
          if [ ! -f "$MYSQL_DIR/data/ibdata1" ]; then
            echo "📦 Inizializzo database..."
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
          
          mysql --host=127.0.0.1 --port=3307 --user=root <<'MYSQL_ROOT'
          CREATE DATABASE IF NOT EXISTS gestione_commesse;
          CREATE USER IF NOT EXISTS 'commesse'@'localhost' IDENTIFIED BY 'commesse';
          CREATE USER IF NOT EXISTS 'commesse'@'127.0.0.1' IDENTIFIED BY 'commesse';
          GRANT ALL PRIVILEGES ON gestione_commesse.* TO 'commesse'@'localhost';
          GRANT ALL PRIVILEGES ON gestione_commesse.* TO 'commesse'@'127.0.0.1';
          FLUSH PRIVILEGES;
MYSQL_ROOT
          
          # 4. Importa dump SQL
          echo "📥 Cerco dump SQL..."
          if [ -f "db/gestione_commesse.sql" ]; then
            echo "✅ Trovato: db/gestione_commesse.sql"
            echo "📊 Righe: $(wc -l < db/gestione_commesse.sql)"
            
            # Importa
            echo "Importazione in corso..."
            mysql --host=127.0.0.1 --port=3307 --user=commesse --password=commesse gestione_commesse < db/gestione_commesse.sql 2>&1 | tail -5
            
            # Conta tabelle
            TABLES=$(mysql --host=127.0.0.1 --port=3307 --user=commesse --password=commesse gestione_commesse -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'gestione_commesse';" 2>/dev/null || echo "0")
            echo "✅ Importate $TABLES tabelle"
          else
            echo "❌ File non trovato: db/gestione_commesse.sql"
            ls -la db/ 2>/dev/null || echo "Cartella db non esiste"
          fi
          
          # 5. SETUP TOMCAT NELLA CARTELLA DEL PROGETTO
          echo "🐈 Setup Tomcat in $PROJECT_DIR/tomcat10..."
          
          # Crea directory Tomcat nel progetto
          TOMCAT_DIR="$PROJECT_DIR/tomcat10"
          mkdir -p "$TOMCAT_DIR"/{bin,conf,lib,logs,temp,webapps,work}
          
          # Copia i file da Tomcat Nix al nostro Tomcat locale
          echo "📦 Copio file Tomcat..."
          
          # Source Tomcat da Nix
          NIX_TOMCAT="${pkgs.tomcat10}"
          
          # Copia binari
          cp -r "$NIX_TOMCAT/bin/"* "$TOMCAT_DIR/bin/" 2>/dev/null || true
          chmod +x "$TOMCAT_DIR/bin/"*.sh 2>/dev/null || true
          
          # Copia librerie
          cp -r "$NIX_TOMCAT/lib/"* "$TOMCAT_DIR/lib/" 2>/dev/null || true
          
          # Copia configurazione
          if [ -d "$NIX_TOMCAT/conf" ]; then
            cp -r "$NIX_TOMCAT/conf/"* "$TOMCAT_DIR/conf/" 2>/dev/null || true
          fi
          
          # Crea file di configurazione minimali se non esistono
          if [ ! -f "$TOMCAT_DIR/conf/server.xml" ]; then
            cat > "$TOMCAT_DIR/conf/server.xml" <<'TOMCAT_CONF'
<?xml version="1.0" encoding="UTF-8"?>
<Server port="8005" shutdown="SHUTDOWN">
  <Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost">
      <Host name="localhost" appBase="webapps"
            unpackWARs="true" autoDeploy="true">
      </Host>
    </Engine>
  </Service>
</Server>
TOMCAT_CONF
          fi
          
          # Copia WAR se esiste
          if [ -f "deploy/app.war" ]; then
            cp deploy/app.war "$TOMCAT_DIR/webapps/ROOT.war"
            echo "📦 Copiato app.war"
          else
            # Crea applicazione di test
            cat > "$TOMCAT_DIR/webapps/ROOT/index.html" <<'HTML'
<!DOCTYPE html>
<html>
<head><title>Portale Commesse</title></head>
<body>
  <h1>Portale Commesse</h1>
  <p>Tomcat attivo su porta 8080</p>
  <p>Database: gestione_commesse</p>
</body>
</html>
HTML
          fi
          
          # Avvia Tomcat
          echo "🚀 Avvio Tomcat..."
          export CATALINA_HOME="$TOMCAT_DIR"
          export CATALINA_BASE="$TOMCAT_DIR"
          
          cd "$TOMCAT_DIR"
          ./bin/catalina.sh start > "$TOMCAT_DIR/logs/catalina.out" 2>&1 &
          cd "$PROJECT_DIR"
          
          sleep 3
          
          # 6. Info finali
          echo ""
          echo "✅ AMBIENTE PRONTO"
          echo "=================="
          echo "📁 Struttura progetto:"
          echo "   $PROJECT_DIR/"
          echo "   ├── tomcat10/          # Tomcat locale"
          echo "   ├── mysql-data/        # Database MariaDB"
          echo "   ├── db/                # Dump SQL"
          echo "   └── deploy/            # File applicazione"
          echo ""
          echo "📦 Database:"
          echo "   mysql -h 127.0.0.1 -P 3307 -u commesse -pcommesse gestione_commesse"
          echo "   Tabelle: $TABLES"
          echo ""
          echo "🌐 Tomcat:"
          echo "   URL: http://localhost:8080"
          echo "   Directory: $TOMCAT_DIR"
          echo "   Logs: $TOMCAT_DIR/logs/catalina.out"
          echo ""
          echo "🔧 Verifica:"
          curl -s http://localhost:8080 | grep -o "<title>[^<]*</title>" || echo "   Tomcat in avvio..."
          echo ""
          echo "🛑 Comandi di arresto:"
          echo "   $TOMCAT_DIR/bin/catalina.sh stop"
          echo "   pkill -f mysqld"
          echo ""
        '';
      };
    };
}
