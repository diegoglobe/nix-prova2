# Deploy automatico per localhost
{ config, pkgs, ... }:

let
  # Path ai file nel repository
  warFile = ./../deploy/commesse-0.0.1-SNAPSHOT.war;
  sqlFile = ./../db/gestione_commesse.sql;
  frontendDir = ./../tomcat10/webapps/commesse;
  
  tomcatDir = "/var/lib/tomcat10";
  webappsDir = "${tomcatDir}/webapps";
in
{
  systemd.services.deploy-commesse = {
    description = "Deploy applicazione Commesse in laboratorio";
    after = [ "tomcat.service" "mysql.service" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "tomcat";
      Group = "tomcat";
    };
    
    script = ''
      echo "=== DEPLOY PORTALE COMMESSE (localhost) ==="
      
      # 1. Importa database (se esiste)
      if [ -f "${sqlFile}" ]; then
        echo "📦 Importazione database..."
        
        # Attendi che MySQL sia pronto
        for i in {1..30}; do
          if mysql -u commesse -pcommesse -e "SELECT 1" >/dev/null 2>&1; then
            echo "✅ MySQL pronto"
            break
          fi
          echo "⏳ Attendo MySQL... ($i/30)"
          sleep 2
        done
        
        mysql -u commesse -pcommesse gestione_commesse < "${sqlFile}" && \
          echo "✅ Database importato" || \
          echo "⚠️  Attenzione: problemi con import database"
      else
        echo "ℹ️  Nessun file SQL trovato, salto import database"
      fi
      
      # 2. Deploy WAR in Tomcat
      if [ -f "${warFile}" ]; then
        echo "📦 Deploy WAR in Tomcat..."
        
        # Crea directory se non esiste
        mkdir -p ${webappsDir}
        
        # Copia WAR
        cp "${warFile}" ${webappsDir}/commesse-0.0.1-SNAPSHOT.war
        chown tomcat:tomcat ${webappsDir}/commesse-0.0.1-SNAPSHOT.war
        
        # Crea context XML
        mkdir -p ${tomcatDir}/conf/Catalina/localhost
        cat > ${tomcatDir}/conf/Catalina/localhost/commesse-0.0.1-SNAPSHOT.xml << EOF
        <?xml version="1.0" encoding="UTF-8"?>
        <Context path="/commesse-0.0.1-SNAPSHOT" 
                 docBase="${webappsDir}/commesse-0.0.1-SNAPSHOT.war"
                 unpackWAR="true"
                 reloadable="true">
          
          <!-- Configurazione database -->
          <Resource name="jdbc/gestione_commesse"
                    auth="Container"
                    type="javax.sql.DataSource"
                    maxTotal="100"
                    maxIdle="30"
                    maxWaitMillis="10000"
                    username="commesse"
                    password="commesse"
                    driverClassName="org.mariadb.jdbc.Driver"
                    url="jdbc:mariadb://localhost:3306/gestione_commesse"/>
          
        </Context>
        EOF
        
        # Copia frontend Angular se esiste
        if [ -d "${frontendDir}" ]; then
          echo "🎨 Copia frontend Angular..."
          mkdir -p ${webappsDir}/commesse-0.0.1-SNAPSHOT
          cp -r ${frontendDir}/* ${webappsDir}/commesse-0.0.1-SNAPSHOT/ 2>/dev/null || true
          chown -R tomcat:tomcat ${webappsDir}/commesse-0.0.1-SNAPSHOT
        fi
        
        echo "✅ WAR deployato in ${webappsDir}/"
      else
        echo "⚠️  Nessun file WAR trovato in ${warFile}"
        echo "📝 Creazione applicazione di test..."
        
        # Crea una semplice app di test
        mkdir -p ${webappsDir}/commesse-0.0.1-SNAPSHOT/WEB-INF
        cat > ${webappsDir}/commesse-0.0.1-SNAPSHOT/index.jsp << EOF
        <%@ page contentType="text/html; charset=UTF-8" %>
        <!DOCTYPE html>
        <html>
        <head><title>Commesse - Test</title></head>
        <body>
          <h1>🚀 Portale Commesse - Ambiente Test</h1>
          <p>Apache: https://localhost:9090</p>
          <p>Tomcat: http://localhost:8080</p>
          <p>MySQL: localhost:3306</p>
          <hr>
          <p>Per deployare l'applicazione reale:</p>
          <ol>
            <li>Metti il file WAR in deploy/commesse-0.0.1-SNAPSHOT.war</li>
            <li>Metti lo schema SQL in db/gestione_commesse.sql</li>
            <li>Riesegui: sudo nixos-rebuild switch</li>
          </ol>
        </body>
        </html>
        EOF
        chown -R tomcat:tomcat ${webappsDir}/commesse-0.0.1-SNAPSHOT
      fi
      
      # 3. Riavvia Tomcat per applicare cambiamenti
      echo "🔄 Riavvio Tomcat..."
      systemctl restart tomcat 2>/dev/null || systemctl start tomcat
      
      echo ""
      echo "========================================"
      echo "✅ DEPLOY COMPLETATO!"
      echo "========================================"
      echo ""
      echo "🌐 URL APPLICAZIONE:"
      echo "  https://localhost:9090/commesse-0.0.1-SNAPSHOT"
      echo ""
      echo "🔧 SERVIZI DIRETTI:"
      echo "  Apache (proxy): https://localhost:9090"
      echo "  Tomcat:         http://localhost:8080"
      echo "  MySQL:          localhost:3306"
      echo ""
      echo "👤 CREDENZIALI:"
      echo "  MySQL - utente: commesse, password: commesse"
      echo ""
      echo "📝 NOTE:"
      echo "  • Accetta il certificato SSL autofirmato nel browser"
      echo "  • Per aggiornamenti: modifica file e ri-esegui:"
      echo "    sudo nixos-rebuild switch --flake .#portale-commesse"
      echo "========================================"
    '';
  };
}
