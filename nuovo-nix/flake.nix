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
          HOME_DIR="$HOME"
          echo "📁 Directory progetto: $PROJECT_DIR"
          echo "🏠 Home: $HOME_DIR"
          
          # 1. Ferma servizi precedenti
          echo "🛑 Fermo servizi precedenti..."
          killall mysqld 2>/dev/null || true
          
          # Ferma Tomcat se esiste
          if [ -f "$HOME_DIR/tomcat10/bin/catalina.sh" ]; then
            "$HOME_DIR/tomcat10/bin/catalina.sh" stop 2>/dev/null || true
            sleep 2
          fi
          
          # 2. Setup MariaDB
          echo "🗄️  Configuro MariaDB..."
          MYSQL_DIR="$PROJECT_DIR/mysql-data"
          mkdir -p "$MYSQL_DIR/data"
          
          if [ ! -f "$MYSQL_DIR/data/ibdata1" ]; then
            echo "📦 Inizializzo database..."
            mysql_install_db \
              --auth-root-authentication-method=normal \
              --datadir="$MYSQL_DIR/data" \
              --basedir=${pkgs.mariadb}
          fi
          
          mysqld_safe \
            --datadir="$MYSQL_DIR/data" \
            --socket="$MYSQL_DIR/mysql.sock" \
            --port=3307 \
            --pid-file="$MYSQL_DIR/mysql.pid" \
            --log-error="$MYSQL_DIR/mysql.log" &
          
          echo "⏳ Attendo avvio MariaDB..."
          sleep 8
          
          # 3. Configura database
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
          if [ -f "db/gestione_commesse.sql" ]; then
            echo "📥 Importo dump SQL..."
            mysql --host=127.0.0.1 --port=3307 --user=commesse --password=commesse gestione_commesse < db/gestione_commesse.sql 2>&1 | tail -5
          fi
          
          # 5. SETUP TOMCAT (nella home come nella VM)
          echo "🐈 Setup Tomcat in $HOME_DIR/tomcat10..."
          
          TOMCAT_DIR="$HOME_DIR/tomcat10"
          
          # Se Tomcat non esiste in home, copialo dal progetto o da Nix
          if [ ! -d "$TOMCAT_DIR" ]; then
            echo "📦 Copio Tomcat in home..."
            mkdir -p "$TOMCAT_DIR"
            
            # Prima prova a copiare dal progetto
            if [ -d "$PROJECT_DIR/tomcat10" ]; then
              cp -r "$PROJECT_DIR/tomcat10/"* "$TOMCAT_DIR/" 2>/dev/null || true
            else
              # Altrimenti copia da Nix
              cp -r ${pkgs.tomcat10}/* "$TOMCAT_DIR/" 2>/dev/null || true
            fi
          fi
          
          # Assicurati che i file di log esistano
          mkdir -p "$TOMCAT_DIR/logs"
          touch "$TOMCAT_DIR/logs/catalina.out"
          
          # 6. CREA/CONFIGURA IL TUO SCRIPT DI AVVIO
          echo "📝 Configuro script di avvio personalizzato..."
          
          cat > "$HOME_DIR/start_tomcat.sh" <<'START_SCRIPT'
#!/bin/bash

# Percorsi specifici per Tomcat 10.1.39
TOMCAT_DIR="$HOME/tomcat10"
TOMCAT_LOG_CONFIG="Djava.util.logging.config.file=$TOMCAT_DIR/conf/logging.properties"

green='\033[0;32m'
red='\033[0;31m'
NC='\033[0m' # No Color
TMAX=30 # Tempo massimo di attesa (in secondi)

################### SCRIPT VERIFICA PROCESSO

CMDLINUX=" grep | less | vi | vim | od | nano | more | tail | ed "

NAMEPROC=$(basename $0)
RESU_CHECK_PRC=$(ps -ef|grep -v " $$ "|egrep -v "$CMDLINUX" |grep -q "$NAMEPROC"$; echo $?)

if [ $RESU_CHECK_PRC = "0" ]; then
        echo -e "${red} $(date +"%Y-%m-%d %H:%M:%S") Process $NAMEPROC Already Running ${NC}"
        exit 1
fi

# =======================================================
# START TOMCAT GESTIONE_COMMESSE
# =======================================================

echo -e "${green}Avvio Apache Tomcat 10.1.39 con JAVA_HOME: $JAVA_HOME${NC}"

# Avvia Tomcat dalla directory bin
cd $TOMCAT_DIR/bin
./startup.sh &>/dev/null

sleep 4

# Verifica avvio
if ps aux | grep -q "[c]atalina"; then
    echo -e "${green}✅ Tomcat avviato correttamente${NC}"
    echo "📁 Directory: $TOMCAT_DIR"
    echo "🌐 URL: http://localhost:8080"
    echo "📋 Logs: $TOMCAT_DIR/logs/catalina.out"
else
    echo -e "${red}❌ Tomcat non avviato${NC}"
    exit 1
fi
START_SCRIPT
          
          chmod +x "$HOME_DIR/start_tomcat.sh"
          
          # 7. CREA SERVICE FILE PER SYSTEMD (per produzione)
          echo "⚙️  Creo file di servizio systemd..."
          
          cat > "$PROJECT_DIR/gestione-commesse.service" <<'SERVICE_FILE'
[Unit]
Description=Portale Commesse - Tomcat Service
After=network.target
Wants=mariadb.service
After=mariadb.service

[Service]
Type=forking
User=commesse
Group=commesse
WorkingDirectory=/home/commesse
Environment="JAVA_HOME=/home/commesse/jdk21"
Environment="CATALINA_HOME=/home/commesse/tomcat10"
Environment="CATALINA_BASE=/home/commesse/tomcat10"
ExecStart=/home/commesse/start_tomcat.sh
ExecStop=/home/commesse/tomcat10/bin/shutdown.sh
Restart=always
RestartSec=10
TimeoutStartSec=300

# Security
NoNewPrivileges=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
SERVICE_FILE
          
          # 8. AVVIA TOMCAT CON IL TUO SCRIPT
          echo "🚀 Avvio Tomcat con il tuo script..."
          
          # Esporta JAVA_HOME (Nix gestisce il percorso)
          JAVA_NIX_PATH=$(find /nix/store -name "jdk-21*" -type d 2>/dev/null | head -1)
          export JAVA_HOME=''${JAVA_NIX_PATH:-${pkgs.jdk21}}
          export CATALINA_HOME="$TOMCAT_DIR"
          export CATALINA_BASE="$TOMCAT_DIR"
          
          echo "☕ Java: $JAVA_HOME"
          echo "🐈 Tomcat: $CATALINA_HOME"
          
          # Avvia usando il tuo script
          cd "$TOMCAT_DIR"
          ./bin/catalina.sh start > "$TOMCAT_DIR/logs/catalina.out" 2>&1 &
          cd "$PROJECT_DIR"
          
          sleep 5
          
          # 9. SCRIPT DI MONITORAGGIO E GESTIONE
          echo "📊 Creo script di gestione..."
          
          cat > "$PROJECT_DIR/gestisci-servizi.sh" <<'GESTISCI_SCRIPT'
#!/bin/bash

green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
NC='\033[0m' # No Color

case "$1" in
  start)
    echo -e "${green}🚀 Avvio servizi...${NC}"
    
    # Avvia MariaDB
    if ! ps aux | grep -q "[m]ysqld.*3307"; then
      echo -e "${green}🗄️  Avvio MariaDB...${NC}"
      mysqld_safe --datadir="$PWD/mysql-data/data" --port=3307 &
      sleep 5
    fi
    
    # Avvia Tomcat
    if ! ps aux | grep -q "[c]atalina"; then
      echo -e "${green}🐈 Avvio Tomcat...${NC}"
      cd "$HOME/tomcat10"
      ./bin/catalina.sh start &
      cd -
    fi
    
    sleep 3
    ;;
    
  stop)
    echo -e "${yellow}🛑 Fermo servizi...${NC}"
    
    # Ferma Tomcat
    if [ -f "$HOME/tomcat10/bin/catalina.sh" ]; then
      echo -e "${yellow}🐈 Fermo Tomcat...${NC}"
      "$HOME/tomcat10/bin/catalina.sh" stop 2>/dev/null || true
    fi
    
    # Ferma MariaDB
    echo -e "${yellow}🗄️  Fermo MariaDB...${NC}"
    killall mysqld 2>/dev/null || true
    
    sleep 2
    ;;
    
  restart)
    echo -e "${yellow}🔄 Riavvio servizi...${NC}"
    $0 stop
    sleep 2
    $0 start
    ;;
    
  status|"")
    echo -e "${green}=== PORTA LE COMMESSE - STATO SERVIZI ===${NC}"
    echo ""
    
    # MariaDB
    if ps aux | grep -q "[m]ysqld.*3307"; then
      echo -e "${green}🗄️  MariaDB: ✅ Attivo (porta 3307)${NC}"
      mysql --host=127.0.0.1 --port=3307 -u commesse -pcommesse -e "SELECT 'Database OK' as Status;" gestione_commesse 2>/dev/null || \
        echo -e "${yellow}🗄️  MariaDB: ⚠️  Connessione fallita${NC}"
    else
      echo -e "${red}🗄️  MariaDB: ❌ Non attivo${NC}"
    fi
    
    echo ""
    
    # Tomcat
    if ps aux | grep -q "[c]atalina"; then
      echo -e "${green}🐈 Tomcat: ✅ Processo attivo${NC}"
      if curl -s http://localhost:8080 > /dev/null; then
        echo -e "${green}🌐 Tomcat: ✅ Risponde su porta 8080${NC}"
      else
        echo -e "${yellow}🌐 Tomcat: ⚠️  Non risponde HTTP${NC}"
      fi
      echo "   Logs: $HOME/tomcat10/logs/catalina.out"
    else
      echo -e "${red}🐈 Tomcat: ❌ Non attivo${NC}"
    fi
    
    echo ""
    echo -e "${green}📁 Directory servizi:${NC}"
    echo "   Tomcat:   $HOME/tomcat10/"
    echo "   Database: $PWD/mysql-data/"
    echo "   Script:   $HOME/start_tomcat.sh"
    echo ""
    echo -e "${green}🔧 Comandi:${NC}"
    echo "   $0 start     - Avvia tutti i servizi"
    echo "   $0 stop      - Ferma tutti i servizi"
    echo "   $0 restart   - Riavvia tutti i servizi"
    echo "   $0 status    - Mostra stato (default)"
    ;;
    
  *)
    echo -e "${red}❌ Comando sconosciuto: $1${NC}"
    echo "Usa: $0 [start|stop|restart|status]"
    exit 1
    ;;
esac
GESTISCI_SCRIPT
          
          chmod +x "$PROJECT_DIR/gestisci-servizi.sh"
          
          # 10. INFO FINALI
          echo ""
          echo "✅ AMBIENTE PRONTO"
          echo "=================="
          echo "📁 Struttura servizi:"
          echo "   Tomcat:     $HOME_DIR/tomcat10/"
          echo "   Database:   $PROJECT_DIR/mysql-data/"
          echo "   Script:     $HOME_DIR/start_tomcat.sh"
          echo ""
          echo "🔌 Database:"
          echo "   mysql -h 127.0.0.1 -P 3307 -u commesse -pcommesse gestione_commesse"
          echo ""
          echo "🌐 Tomcat: http://localhost:8080"
          echo ""
          echo "⚙️  Gestione servizi:"
          echo "   ./gestisci-servizi.sh status    # Verifica stato"
          echo "   ./gestisci-servizi.sh restart   # Riavvia tutto"
          echo "   tail -f $HOME_DIR/tomcat10/logs/catalina.out  # Logs Tomcat"
          echo ""
          echo "📋 Per produzione (su VM reale):"
          echo "   sudo cp gestione-commesse.service /etc/systemd/system/"
          echo "   sudo systemctl daemon-reload"
          echo "   sudo systemctl enable --now gestione-commesse"
          echo ""
        '';
      };
    };
}
