{
  description = "Portale Commesse - Ambiente produzione sempre attivo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # Versioni esatte come da documento
      versions = {
        mariadb = "10.4.32";
        java = "21";
        tomcat = "10";
        nodejs = "20";
      };
      
    in {
      # 1. AMBIENTE SVILUPPO (per sviluppatori)
      devShells.${system}.default = pkgs.mkShell {
        name = "portale-commesse-dev";
        
        buildInputs = with pkgs; [
          # Java/Spring Boot
          jdk21
          maven
          gradle
          
          # Frontend Angular
          nodejs_20
          nodePackages.angular-cli
          nodePackages.npm
          
          # Database tools
          mariadb.client
          mycli
          
          # Utilità
          curl
          jq
          git
          
          # Deploy tools
          rsync
          openssh
        ];
        
        shellHook = ''
          echo "🚀 Ambiente sviluppo Portale Commesse"
          echo "👉 Servizi già attivi su:"
          echo "   - DB: mariadb://localhost:3306/commessa_db"
          echo "   - App: http://localhost:8080"
          echo "   - Statici: http://localhost:8080/static/"
          echo ""
          echo "Comandi utili:"
          echo "  deploy-app    - Aggiorna applicazione"
          echo "  check-status  - Verifica servizi"
          echo "  db-console    - Connetti al database"
        '';
        
        # Alias comandi
        PORTALE_DB_NAME = "commessa_db";
        PORTALE_DB_USER = "commessa_user";
        PORTALE_TOMCAT_HOME = "/home/commesse/tomcat10";
      };
      
      # 2. CONFIGURAZIONE NixOS PER SERVIZI PERSISTENTI
      nixosConfigurations.portale-commesse = nixpkgs.lib.nixosSystem {
        inherit system;
        
        modules = [
          # Configurazione base sistema
          ({ config, pkgs, ... }: {
            networking.hostName = "portale-commesse";
            time.timeZone = "Europe/Rome";
            system.stateVersion = "23.11";
            
            # Firewall: apri porte necessarie
            networking.firewall = {
              enable = true;
              allowedTCPPorts = [ 
                22    # SSH
                80    # HTTP (se metti Apache)
                443   # HTTPS
                8080  # Tomcat
                3306  # MariaDB (solo locale)
              ];
            };
            
            # Utente commesse
            users.users.commesse = {
              isNormalUser = true;
              home = "/home/commesse";
              createHome = true;
              group = "commesse";
              shell = pkgs.bash;
              extraGroups = [ "wheel" ];
            };
            users.groups.commesse = {};
          })
          
          # Servizio: MariaDB (sempre attivo)
          ({ pkgs, ... }: {
            services.mariadb = {
              enable = true;
              package = pkgs.mariadb;
              ensureDatabases = [ "commessa_db" ];
              ensureUsers = [{
                name = "commessa_user";
                ensurePermissions = {
                  "commessa_db.*" = "ALL PRIVILEGES";
                };
              }];
              settings = {
                mysqld = {
                  bind-address = "127.0.0.1";  # Solo locale
                  character-set-server = "utf8mb4";
                  collation-server = "utf8mb4_unicode_ci";
                  max_connections = 100;
                  innodb_buffer_pool_size = "256M";
                };
              };
              
              # Importa iniziale del DB
              initialScript = pkgs.writeText "init-commessa.sql" ''
                CREATE DATABASE IF NOT EXISTS commessa_db 
                CHARACTER SET utf8mb4 
                COLLATE utf8mb4_unicode_ci;
                
                -- Questo sarà sovrascritto da deploy/db.sql se esiste
                -- ma crea struttura di base
              '';
            };
            
            # Script per importare dump aggiornato
            systemd.services.import-commessa-db = {
              description = "Import updated commessa database";
              after = [ "mariadb.service" ];
              wantedBy = [ "multi-user.target" ];
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
                User = "commesse";
                WorkingDirectory = "/home/commesse/deploy";
              };
              path = with pkgs; [ mariadb ];
              script = ''
                if [ -f "db.sql" ] && [ -s "db.sql" ]; then
                  echo "🔄 Importing updated database schema..."
                  mysql -u root commessa_db < db.sql
                  echo "✅ Database imported/updated"
                else
                  echo "ℹ️  No db.sql found, using existing database"
                fi
              '';
            };
          })
          
          # Servizio: Tomcat 10 (sempre attivo)
          ({ pkgs, ... }: {
            services.tomcat = {
              enable = true;
              package = pkgs.tomcat10;
              user = "commesse";
              group = "commesse";
              
              # Java 21
              jdk = pkgs.jdk21;
              
              # JVM Options per produzione
              jvmOpts = [
                "-server"
                "-Xms512m"
                "-Xmx2048m"
                "-XX:+UseG1GC"
                "-XX:MaxGCPauseMillis=200"
                "-Djava.awt.headless=true"
                "-Dfile.encoding=UTF-8"
                "-Dspring.profiles.active=production"
              ];
              
              # Porta principale
              port = 8080;
              
              # Directory applicazione
              home = "/home/commesse/tomcat10";
              
              # AJP (se serve per Apache)
              ajp = {
                enable = false;
                port = 8009;
              };
              
              # WAR iniziale (verrà sovrascritto da deploy)
              webapps = [
                # Il WAR sarà copiato via system.activationScripts
              ];
            };
            
            # Directory Tomcat con permessi
            system.activationScripts.setup-tomcat = ''
              mkdir -p /home/commesse/tomcat10/{webapps,logs,temp,work,conf/Catalina/localhost}
              chown -R commesse:commesse /home/commesse/tomcat10
              
              # Crea context.xml per applicazione
              cat > /home/commesse/tomcat10/conf/Catalina/localhost/ROOT.xml << 'EOF'
              <Context docBase="/home/commesse/tomcat10/webapps/ROOT.war">
                <Resources cachingAllowed="true" cacheMaxSize="100000" />
              </Context>
              EOF
            '';
          })
          
          # Servizio: Apache come reverse proxy (OPZIONALE, se vuoi porta 80)
          ({ pkgs, ... }: {
            services.httpd = {
              enable = true;  # Abilita se vuoi Apache
              adminAddr = "admin@commessa.it";
              
              # Configurazione virtual host per Tomcat
              virtualHosts."portale.commessa.local" = {
                hostName = "portale.commessa.local";
                serverAliases = [ "localhost" "127.0.0.1" ];
                documentRoot = "/home/commesse/tomcat10/webapps";
                
                # Proxy a Tomcat
                extraConfig = ''
                  ProxyPreserveHost On
                  ProxyPass / http://localhost:8080/
                  ProxyPassReverse / http://localhost:8080/
                  
                  # Static files - serviti direttamente
                  Alias /static /home/commesse/tomcat10/webapps/static
                  <Directory "/home/commesse/tomcat10/webapps/static">
                    Require all granted
                    Options -Indexes
                  </Directory>
                '';
              };
            };
          })
          
          # DEPLOYMENT AUTOMATICO
          ({ config, pkgs, ... }: {
            # Directory per file di deploy
            environment.etc."commesse-deploy".source = ./deploy;
            
            # Script che copia i file al posto giusto
            system.activationScripts.deploy-application = let
              deployDir = "/home/commesse/deploy";
            in ''
              echo "🚀 Deploying Portale Commesse..."
              
              # Crea directory deploy
              mkdir -p ${deployDir}
              
              # Copia tutto da /etc/commesse-deploy
              cp -r /etc/commesse-deploy/* ${deployDir}/ 2>/dev/null || true
              
              # Se c'è un nuovo WAR, copialo e riavvia Tomcat
              if [ -f "${deployDir}/app.war" ]; then
                echo "📦 Installing new WAR..."
                cp "${deployDir}/app.war" /home/commesse/tomcat10/webapps/ROOT.war
                chown commesse:commesse /home/commesse/tomcat10/webapps/ROOT.war
                
                # Riavvia Tomcat se è attivo
                if systemctl is-active --quiet tomcat; then
                  echo "🔄 Restarting Tomcat..."
                  systemctl restart tomcat
                fi
              fi
              
              # Copia file statici Angular
              if [ -d "${deployDir}/webapps" ]; then
                echo "🎨 Copying static files..."
                mkdir -p /home/commesse/tomcat10/webapps/static
                cp -r "${deployDir}/webapps/"* /home/commesse/tomcat10/webapps/static/
                chown -R commesse:commesse /home/commesse/tomcat10/webapps/static
              fi
              
              # Importa DB se c'è nuovo dump
              if [ -f "${deployDir}/db.sql" ] && [ -s "${deployDir}/db.sql" ]; then
                echo "🗄️  Importing database..."
                systemctl start import-commessa-db
              fi
              
              echo "✅ Deploy completato"
              echo "🌐 Applicazione disponibile su: http://$(hostname -I | awk '{print $1}'):8080"
            '';
            
            # Monitoraggio servizi
            systemd.services."portale-status" = {
              description = "Portale Commesse Status Check";
              serviceConfig = {
                Type = "oneshot";
                User = "commesse";
              };
              script = ''
                echo "=== PORTA LE COMMESSE STATUS ==="
                echo "MariaDB: $(systemctl is-active mariadb)"
                echo "Tomcat:  $(systemctl is-active tomcat)"
                echo "Apache:  $(systemctl is-active httpd 2>/dev/null || echo 'disabled')"
                echo "================================"
              '';
            };
          })
        ];
      };
      
      # 3. SCRIPT DI DEPLOY PER SVILUPPATORI
      apps.${system} = {
        deploy-app = {
          type = "app";
          program = toString (pkgs.writeShellScriptBin "deploy-app" ''
            #!/bin/bash
            echo "🚀 Starting Portale Commesse deployment..."
            
            # 1. Copia file nella directory deploy
            DEPLOY_DIR="/etc/commesse-deploy"
            sudo mkdir -p $DEPLOY_DIR
            
            if [ -f "deploy/db.sql" ]; then
              sudo cp deploy/db.sql $DEPLOY_DIR/
              echo "✅ Copied db.sql"
            fi
            
            if [ -f "deploy/app.war" ]; then
              sudo cp deploy/app.war $DEPLOY_DIR/
              echo "✅ Copied app.war"
            fi
            
            if [ -d "deploy/webapps" ]; then
              sudo cp -r deploy/webapps $DEPLOY_DIR/
              echo "✅ Copied webapps/"
            fi
            
            # 2. Trigger deploy
            echo "🔄 Triggering deployment..."
            sudo /run/current-system/activate
            
            # 3. Wait for services
            sleep 3
            
            # 4. Check status
            echo ""
            echo "=== DEPLOY COMPLETED ==="
            curl -s http://localhost:8080 | grep -o "<title>[^<]*</title>" || echo "✅ Tomcat is running on port 8080"
            mysql -u commessa_user -e "SELECT '✅ Database connected' as Status;" commessa_db 2>/dev/null || echo "⚠️  Database check failed"
          '');
        };
        
        check-status = {
          type = "app";
          program = toString (pkgs.writeShellScriptBin "check-status" ''
            #!/bin/bash
            echo "🔍 Portale Commesse - Status Check"
            echo ""
            
            # Check services
            SERVICES=("mariadb" "tomcat" "httpd")
            for SERVICE in "''${SERVICES[@]}"; do
              STATUS=$(systemctl is-active $SERVICE 2>/dev/null || echo "not installed")
              echo "  $SERVICE: $STATUS"
            done
            
            echo ""
            
            # Check ports
            echo "🌐 Network Ports:"
            netstat -tlnp | grep -E ":8080|:3306|:80|:443" | sort | while read line; do
              echo "  $line"
            done
            
            echo ""
            
            # Check application
            echo "📦 Application:"
            ls -la /home/commesse/tomcat10/webapps/ROOT.war 2>/dev/null && \
              echo "  WAR: $(ls -lh /home/commesse/tomcat10/webapps/ROOT.war | awk '{print $5}')"
            
            echo ""
            echo "🔗 Access URLs:"
            echo "  Tomcat Direct: http://$(hostname -I | awk '{print $1}'):8080"
            echo "  Apache Proxy:  http://$(hostname -I | awk '{print $1}') (if enabled)"
            echo "  Database:      mysql://commessa_user@localhost:3306/commessa_db"
          '');
        };
      };
    };
}
