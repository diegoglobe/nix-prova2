{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      
    in {
      # ========== DEV SHELL COMPLETA ==========
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Stack completo produzione
          apacheHttpd      # Apache per reverse proxy
          tomcat10         # Tomcat 10
          mariadb          # MariaDB 10.11
          jdk21            # Java 21
          
          # Client e utilità
          mariadb-client
          curl
          gnused
          gawk
          netcat
          tree
        ];
        
        # Variabili d'ambiente
        MYSQL_DATA_DIR = "$PWD/mysql-data";
        MYSQL_SOCKET = "$PWD/mysql-data/mysql.sock";
        APACHE_CONFIG_DIR = "$PWD/apache/conf";
        APACHE_LOGS_DIR = "$PWD/apache/logs";
        APACHE_WWW_DIR = "$PWD/apache/www";
        
        shellHook = ''
          echo "🌐 AMBIENTE PORTALE COMMESSE - PRODUZIONE"
          echo "========================================="
          echo ""
          echo "COMPONENTI:"
          echo "• Apache HTTPD 2.4 (reverse proxy)"
          echo "• Tomcat 10.1 (applicazione Spring Boot)"
          echo "• MariaDB 10.11 (database)"
          echo "• JDK 21 (Java)"
          echo ""
          echo "DIRECTORIES:"
          echo "• Database: $MYSQL_DATA_DIR"
          echo "• Apache:   $APACHE_CONFIG_DIR"
          echo "• Tomcat:   $PWD/tomcat10"
          echo ""
          echo "SCRIPT DISPONIBILI:"
          echo "• ./deploy.sh          - Deploy completo"
          echo "• ./apache-setup.sh    - Configura Apache"
          echo "• ./debug.sh           - Debug ambiente"
          echo ""
          echo "URL FINALI:"
          echo "• Frontend: http://localhost:9090/"
          echo "• API:      http://localhost:9090/commesse-0.0.1-SNAPSHOT/"
          echo ""
        '';
      };
      
      # ========== PACCHETTI PRECONFIGURATI ==========
      packages.${system} = {
        # Stack completo come pacchetto
        commesse-stack = pkgs.writeShellScriptBin "commesse-stack" ''
          echo "Stack Portale Commesse installato"
          echo "Usa: nix develop per entrare nell'ambiente"
        '';
      };
    };
}
