# modules/mysql.nix
{ config, lib, pkgs, ... }:
{
  services.mysql = {
    enable = true;
    # Usa mkDefault per evitare conflitti
    package = lib.mkDefault pkgs.mariadb;
    
    ensureDatabases = [ "commesse_db" ];
    ensureUsers = [{
      name = "commesse_user";
      ensurePermissions = {
        "commesse_db.*" = "ALL PRIVILEGES";
      };
    }];
  };
}
