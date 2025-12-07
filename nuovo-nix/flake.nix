{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # 1. DEV SHELL (manteniamo quello esistente)
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          jdk21
          nodejs_20
          nodePackages."@angular/cli"
          mariadb
          mariadb-client
          tomcat10
          apacheHttpd
        ];

        shellHook = ''
          # ... [MANTIENI IL TUO SCRIPT ATTIVO] ...
          echo "⚡ Ambiente di sviluppo Commesse"
          echo "MySQL: localhost:3306"
          echo "Tomcat: http://localhost:8080"
          echo "Apache: https://localhost:9090 (dopo avvio produzione)"
        '';
      };

      # 2. CONFIGURAZIONE NIXOS PER PRODUZIONE/LAB
      nixosConfigurations.portale-commesse = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/apache.nix
          ./modules/tomcat.nix
          ./modules/mysql.nix
          ./modules/deploy.nix
          
          ({ config, pkgs, ... }: {
            networking.hostName = "localhost";
            networking.domain = "local";
            
            # NON serve IP statico, usiamo localhost
            # networking.interfaces.eth0.ipv4.addresses = [{
            #   address = "192.168.1.68";
            #   prefixLength = 24;
            # }];
            
            # Rimuovi anche l'extraHosts per pantheon.medialogic.it
            # networking.extraHosts = ''
            #   192.168.1.68 pantheon.medialogic.it
            # '';
            
            # Apri solo le porte necessarie in locale
            networking.firewall.enable = false;  # Disabilita firewall in lab
            
            time.timeZone = "Europe/Rome";
            
            # Utente per gestione
            users.users.commesse = {
              isNormalUser = true;
              extraGroups = [ "wheel" ];
              # Se vuoi SSH locale
              # openssh.authorizedKeys.keys = [ "ssh-ed25519 ..." ];
            };
            
            # Abilita SSH se serve
            services.openssh.enable = true;
            
            system.stateVersion = "23.11";
          })
        ];
      };
    };
}
