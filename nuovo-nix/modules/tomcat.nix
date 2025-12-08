{ config, lib, pkgs, ... }:
{
  services.tomcat = {
    enable = true;
    package = pkgs.tomcat10;
    
    # ✅ CORRETTO per nixos-23.11: javaOpts (non jvmOpts)
    javaOpts = [
      "-Xms512m"
      "-Xmx1024m"
      "-Djava.awt.headless=true"
      "-Dfile.encoding=UTF-8"
    ];
    
    # Configurazione base
    user = "tomcat";
    group = "tomcat";
    baseDir = "/var/lib/tomcat";
  };
  
  # Crea utente e gruppo tomcat - SENZA definire 'home' (lascia il default)
  users.users.tomcat = {
    isSystemUser = true;
    group = "tomcat";
    # RIMUOVI questa riga: home = "/var/lib/tomcat";
    # RIMUOVI questa riga: createHome = true;
  };
  users.groups.tomcat = {};
}
