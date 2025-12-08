# modules/tomcat.nix
{ config, pkgs, ... }:

{
  services.tomcat = {
    enable = true;
    package = pkgs.tomcat10;
    
    # Non serve più specificare user/group, NixOS li gestisce
    
    # Java options
    jvmOpts = [
      "-Xms512m"
      "-Xmx1024m"
      "-Djava.awt.headless=true"
      "-Dfile.encoding=UTF-8"
      "-Djava.security.egd=file:/dev/./urandom"
    ];
  };
}
