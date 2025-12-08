# modules/mysql.nix
{ config, pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    ensureDatabases = [ "gestione_commesse" ];
    ensureUsers = [
      {
        name = "commesse";
        ensurePermissions = {
          "gestione_commesse.*" = "ALL PRIVILEGES";
        };
      }
    ];
    
    settings = {
      mysqld = {
        bind-address = "127.0.0.1";
        character-set-server = "utf8mb4";
        collation-server = "utf8mb4_unicode_ci";
      };
    };

    # Imposta password
    initialScript = pkgs.writeText "mysql-init" ''
      ALTER USER 'commesse'@'localhost' IDENTIFIED BY 'commesse';
      FLUSH PRIVILEGES;
    '';
  };
}
