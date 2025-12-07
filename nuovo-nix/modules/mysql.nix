# MariaDB/MySQL
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
    
    # Imposta password (cambiala se vuoi)
    initialScript = pkgs.writeText "mysql-init" ''
      ALTER USER 'commesse'@'localhost' IDENTIFIED BY 'commesse';
    '';
  };
}
