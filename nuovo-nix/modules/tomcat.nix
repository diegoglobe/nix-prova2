# PRIMA: rimuovi il file danneggiato
rm modules/tomcat.nix

# POI: crea il file CORRETTO
cat > modules/tomcat.nix << 'EOF'
{ config, pkgs, ... }:
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
  
  # Crea utente e gruppo tomcat
  users.users.tomcat = {
    isSystemUser = true;
    group = "tomcat";
    home = "/var/lib/tomcat";
    createHome = true;
  };
  users.groups.tomcat = {};
}
EOF# PRIMA: rimuovi il file danneggiato
rm modules/tomcat.nix

# POI: crea il file CORRETTO
cat > modules/tomcat.nix << 'EOF'
{ config, pkgs, ... }:
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
  
  # Crea utente e gruppo tomcat
  users.users.tomcat = {
    isSystemUser = true;
    group = "tomcat";
    home = "/var/lib/tomcat";
    createHome = true;
  };
  users.groups.tomcat = {};
}
