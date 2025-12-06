{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      
      # Percorso del tuo dump SQL (mettilo nella cartella `db/`)
      dbDump = ./db/gestione_commesse.sql;
      
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Java 21
          jdk21
          
          # Node.js 20
          nodejs_20
          
          # Angular CLI
          nodePackages."@angular/cli"
          
          # MariaDB (client + server)
          mariadb
          mariadb-client
          
          # Tomcat 10
          tomcat10
          
          # Apache 2.4
          apacheHttpd
          
          # Utilità
          git
          curl
          gnused
        ];

        # Script che viene eseguito quando entri in nix develop
        shellHook = ''
          echo "🚀 Avvio ambiente Portale Commesse..."
          
          # 1. Crea directory necessarie
          mkdir -p /tmp/commesse/{db,tomcat,logs}
          
          # 2. AVVIA MARIA DB
          echo "🗄️  Avvio MariaDB..."
          
          # Inizializza database se non esiste
          if [ ! -d "/tmp/commesse/db/data" ]; then
            echo "📦 Inizializzo database..."
            mysql_install_db \
              --auth-root-authentication-method=normal \
              --datadir=/tmp/commesse/db/data \
              --basedir=${pkgs.mariadb}
          fi
          
          # Avvia MariaDB in background
          mysqld_safe \
            --datadir=/tmp/commesse/db/data \
            --socket=/tmp/commesse/db/mysql.sock \
            --port=3307 \
            --pid-file=/tmp/commesse/db/mysql.pid \
            --log-error=/tmp/commesse/logs/mysql.log &
          
          # Attendi che MariaDB sia pronto
          sleep 3
          
          # 3. CONFIGURA UTENTE E DATABASE
          echo "👤 Configuro utente 'commesse' e database..."
          
          # Crea utente commesse (senza password per semplicità)
          mysqladmin --host=127.0.0.1 --port=3307 --user=root --password= create 2>/dev/null || true
          
          mysql --host=127.0.0.1 --port=3307 --user=root <<EOF
          CREATE DATABASE IF NOT EXISTS gestione_commesse;
          CREATE USER IF NOT EXISTS 'commesse'@'localhost' IDENTIFIED BY 'commesse';
          GRANT ALL PRIVILEGES ON gestione_commesse.* TO 'commesse'@'localhost';
          GRANT ALL PRIVILEGES ON gestione_commesse.* TO 'commesse'@'127.0.0.1';
          FLUSH PRIVILEGES;
          EOF
          
          # 4. IMPORTA IL DUMP SQL (se il file esiste)
          if [ -f "${dbDump}" ]; then
            echo "📥 Importo dump SQL..."
            mysql --host=127.0.0.1 --port=3307 --user=commesse gestione_commesse < "${dbDump}"
            echo "✅ Database inizializzato con dump SQL"
          else
            echo "⚠️  Nessun dump SQL trovato in ${dbDump}"
          fi
          
          # 5. AVVIA TOMCAT
          echo "🐈 Avvio Tomcat..."
          
          # Crea directory Tomcat
          mkdir -p /tmp/commesse/tomcat/{webapps,logs,temp,work}
          
          # Copia WAR di esempio se esiste
          if [ -f "deploy/app.war" ]; then
            cp deploy/app.war /tmp/commesse/tomcat/webapps/ROOT.war
          fi
          
          # Avvia Tomcat
          export CATALINA_HOME=${pkgs.tomcat10}
          export CATALINA_BASE=/tmp/commesse/tomcat
          ${pkgs.tomcat10}/bin/catalina.sh start > /tmp/commesse/logs/tomcat.log 2>&1 &
          
          sleep 2
          
          # 6. INFORMAZIONI FINALI
          echo ""
          echo "✅ AMBIENTE PRONTO"
          echo "=================="
          echo "📦 Database MariaDB:"
          echo "   Host: 127.0.0.1:3307"
          echo "   Utente: commesse (no password)"
          echo "   Database: gestione_commesse"
          echo ""
          echo "🌐 Tomcat:"
          echo "   URL: http://localhost:8080"
          echo "   Logs: /tmp/commesse/logs/tomcat.log"
          echo ""
          echo "🔧 Comandi utili:"
          echo "   mysql -h 127.0.0.1 -P 3307 -u commesse gestione_commesse"
          echo "   tail -f /tmp/commesse/logs/tomcat.log"
          echo "   curl http://localhost:8080"
          echo ""
          echo "⚠️  Per fermare i servizi:"
          echo "   pkill -f mysqld"
          echo "   ${pkgs.tomcat10}/bin/catalina.sh stop"
          echo ""
        '';
      };

      # Pacchetto con solo i file (senza servizi)
      packages.${system}.deploy-files = pkgs.runCommand "deploy-files" {} ''
        mkdir -p $out
        echo "=== FILE DI DEPLOY ===" > $out/README.txt
        echo "" >> $out/README.txt
        echo "Struttura:" >> $out/README.txt
        echo "- db/gestione_commesse.sql    # Dump database" >> $out/README.txt
        echo "- deploy/app.war              # Applicazione WAR" >> $out/README.txt
        echo "- deploy/webapps/             # File statici Angular" >> $out/README.txt
      '';
    };
}
