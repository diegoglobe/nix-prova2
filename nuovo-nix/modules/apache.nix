# modules/apache.nix - CORRETTO per NixOS 23.11
{ config, pkgs, lib, ... }:

let
  certDir = "/etc/apache2/certs";
in
{
  services.httpd = {
    enable = true;
    adminAddr = "admin@localhost";
    
    # Configurazione globale
    extraModules = [
      "proxy"
      "proxy_http" 
      "ssl"
      "headers"
    ];
    
    # VirtualHost per porta 9090
    virtualHosts = {
      "localhost-9090" = {
        hostName = "localhost";
        serverAliases = [ "127.0.0.1" ];
        
        # Ascolta sulla porta 9090 con SSL
        listen = [
          { 
            ip = "*";
            port = 9090;
            ssl = true;
          }
        ];
        
        documentRoot = "/var/www/commesse";
        
        # Configurazione extra del VirtualHost
        extraConfig = ''
          <Directory "/var/www/commesse">
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
          </Directory>
          
          # Log files
          ErrorLog /var/log/apache2/commesse-error.log
          CustomLog /var/log/apache2/commesse-access.log combined
          
          # Proxy configuration
          ProxyRequests Off
          ProxyPreserveHost On
          ProxyPass /commesse-0.0.1-SNAPSHOT http://localhost:8080/commesse-0.0.1-SNAPSHOT
          ProxyPassReverse /commesse-0.0.1-SNAPSHOT http://localhost:8080/commesse-0.0.1-SNAPSHOT
          
          # CORS headers
          Header always set Access-Control-Allow-Origin "https://localhost:9090"
          Header always set Access-Control-Allow-Credentials "true"
          Header always set Access-Control-Allow-Headers "Content-Type, Authorization, X-Requested-With"
          Header always set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
          
          # Gestione preflight OPTIONS
          RewriteEngine On
          RewriteCond %{REQUEST_METHOD} OPTIONS
          RewriteRule ^(.*)$ $1 [R=200,L]
        '';
        
        # SSL configuration - usiamo certificati autofirmati
        enableSSL = true;
        sslServerCert = "${certDir}/localhost.crt";
        sslServerKey = "${certDir}/localhost.key";
        
        # Aggiungi anche per compatibilità
        addSSL = true;
      };
    };
  };
  
  # Script per setup iniziale
  system.activationScripts.setup-apache = ''
    echo "=== Setting up Apache for Portale Commesse ==="
    
    # Create directories
    mkdir -p ${certDir}
    mkdir -p /var/www/commesse
    mkdir -p /var/log/apache2
    
    # Generate self-signed certificate if it doesn't exist
    if [ ! -f ${certDir}/localhost.key ]; then
      echo "Generating self-signed SSL certificate for localhost..."
      ${pkgs.openssl}/bin/openssl req -x509 \
        -newkey rsa:2048 \
        -keyout ${certDir}/localhost.key \
        -out ${certDir}/localhost.crt \
        -days 3650 \
        -nodes \
        -subj "/C=IT/ST=Lombardia/L=Milano/O=Medialogic/CN=localhost" \
        -addext "subjectAltName = DNS:localhost, IP:127.0.0.1"
      
      chmod 600 ${certDir}/localhost.key
      echo "✅ SSL certificate generated in ${certDir}/"
    fi
    
    # Create a simple test page
    cat > /var/www/commesse/index.html << 'EOF'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Portale Commesse - Apache</title>
      <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { background: #f8f9fa; padding: 20px; margin: 20px 0; border-radius: 8px; border-left: 4px solid #007bff; }
        .success { color: #28a745; }
        .warning { color: #ffc107; }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>🚀 Apache Proxy Server</h1>
        <p class="success">✅ Apache is running on port 9090</p>
        
        <div class="card">
          <h2>📡 Proxy Configuration</h2>
          <p><strong>From:</strong> <code>https://localhost:9090/commesse-0.0.1-SNAPSHOT</code></p>
          <p><strong>To:</strong> <code>http://localhost:8080/commesse-0.0.1-SNAPSHOT</code></p>
          <p><em>Apache → Tomcat reverse proxy</em></p>
        </div>
        
        <div class="card">
          <h2>🔐 SSL Certificate</h2>
          <p>Self-signed certificate for localhost</p>
          <p class="warning">⚠️ Accept the security exception in your browser</p>
        </div>
        
        <div class="card">
          <h2>🔗 Quick Links</h2>
          <ul>
            <li><a href="/commesse-0.0.1-SNAPSHOT">Go to Application</a></li>
            <li><a href="http://localhost:8080">Direct Tomcat Access</a></li>
          </ul>
        </div>
      </div>
    </body>
    </html>
    EOF
    
    echo "✅ Apache setup complete!"
    echo "🌐 Access at: https://localhost:9090"
  '';
}
