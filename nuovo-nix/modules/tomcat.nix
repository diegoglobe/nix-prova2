# Tomcat 10
{ config, pkgs, ... }:

{
  services.tomcat = {
    enable = true;
    package = pkgs.tomcat10;
    
    user = "tomcat";
    group = "tomcat";
    
    jvmOpts = [
      "-Xms512m"
      "-Xmx1024m"
      "-Djava.awt.headless=true"
      "-Dfile.encoding=UTF-8"
    ];
  };
}
