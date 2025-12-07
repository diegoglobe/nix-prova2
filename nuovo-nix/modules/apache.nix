# Configurazione Apache per localhost
{ config, pkgs, ... }:

let
  certDir = "/etc/apache2/certs";
  logDir = "/var/log/apache2";  # Usa directory standard
  
  # Configurazione SEMPLIFICATA per localhost
  virtualHostConfig = ''
    <IfModule mod_ssl.c>
      <VirtualHost localhost:9090>
        ServerName localhost
        DocumentRoot /var/www/commesse

        <Directory /var/www/commesse>
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
        </Directory>

        ErrorLog ${logDir}/commesse-error.log
        CustomLog ${logDir}/commesse-access.log combined

        SSLEngine on
        SSLCertificateFile ${certDir}/localhost.crt
        SSLCertificateKeyFile ${certDir}/localhost.key

        ProxyPreserveHost On
        ProxyPass /commesse-0.0.1-SNAPSHOT  http://localhost:8080/commesse-0.0.1-SNAPSHOT
        ProxyPassReverse /commesse-0.0.1-SNAPSHOT http://localhost:8080/commesse-0.0.1-SNAPSHOT

        # CORS semplificato per localhost
        Header always set Access-Control-Allow-Origin "https://localhost:9090"
        Header always set Access-Control-Allow-Credentials "true"
        Header always set Access-Control-Allow-Headers "Content-Type, Authorization, X-Requested-With"
        Header always set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"

        <Location "/commesse-0.0.1-SNAPSHOT/api">
          Header always set Access-Control-Allow-Origin "https://localhost:9090"
          Header always set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
          Header always set Access-Control-Allow-Headers "Content-Type, Authorization, X-Requested-With"
        </Location>
      </VirtualHost>
    </IfModule>
  '';
in
{
  services.httpd = {
    enable = true;
    enableModules = [ "proxy" "proxy_http" "ssl" "headers" ];
    
    extraConfig = ''
      Listen 9090
      ${virtualHostConfig}
    '';
    
    user = "www-data";
    group = "www-data";
  };
  
  # Creazione directory e certificati per localhost
  system.activationScripts.setup-apache = ''
    mkdir -p ${certDir}
    mkdir -p /var/www/commesse
    
    # Genera certificati autofirmati per localhost
    if [ ! -f ${certDir}/localhost.key ]; then
      echo "Generazione certificati SSL per localhost..."
      ${pkgs.openssl}/bin/openssl req -x509 \
        -newkey rsa:2048 \
        -keyout ${certDir}/localhost.key \
        -out ${certDir}/localhost.crt \
        -days 3650 \
        -nodes \
        -subj "/C=IT/ST=Lombardia/L=Milano/O=LocalLab/CN=localhost" \
        -addext "subjectAltName = DNS:localhost, IP:127.0.0.1"
      
      chmod 600 ${certDir}/localhost.key
      
      # Aggiungi certificato ai trusted (opzionale, per evitare warning browser)
      ${pkgs.cacert}/bin/update-ca-certificates || true
    fi
    
    # Pagina di test semplice
    cat > /var/www/commesse/index.html << EOF
    <!DOCTYPE html>
    <html>
    <head>
      <title>Portale Commesse - Laboratorio</title>
      <style>
        body { font-family: sans-serif; margin: 40px; }
        .box { border: 1px solid #ccc; padding: 20px; margin: 10px 0; border-radius: 5px; }
        a { color: #0066cc; text-decoration: none; }
        a:hover { text-decoration: underline; }
      </style>
    </head>
    <body>
      <h1>🚀 Portale Commesse - Ambiente Laboratorio</h1>
      
      <div class="box">
        <h2>Apache (HTTPS Proxy)</h2>
        <p><strong>Porta:</strong> 9090</p>
        <p><strong>URL:</strong> <a href="https://localhost:9090">https://localhost:9090</a></p>
        <p><em>Certificato autofirmato - accetta l'eccezione nel browser</em></p>
      </div>
      
      <div class="box">
        <h2>Applicazione Commesse</h2>
        <p><a href="/commesse-0.0.1-SNAPSHOT">Vai all'applicazione →</a></p>
        <p><strong>Proxy:</strong> Apache → Tomcat</p>
      </div>
      
      <div class="box">
        <h2>Servizi diretti (senza proxy)</h2>
        <ul>
          <li><a href="http://localhost:8080">Tomcat (8080)</a></li>
          <li>MySQL (3306) - phpMyAdmin non installato</li>
        </ul>
      </div>
      
      <div class="box">
        <h2>Comandi utili</h2>
        <pre>
# Test Apache
curl -k https://localhost:9090

# Test Tomcat
curl http://localhost:8080/commesse-0.0.1-SNAPSHOT/

# Test MySQL
mysql -u commesse -p gestione_commesse
        </pre>
      </div>
    </body>
    </html>
    EOF
    
    chown -R www-data:www-data /var/www/commesse
    echo "✅ Apache configurato su https://localhost:9090"
  '';
}
