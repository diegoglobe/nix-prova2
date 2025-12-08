# modules/deploy.nix
{ config, pkgs, ... }:

{
  # Simple echo to show deployment would happen
  system.activationScripts.deploy-echo = ''
    echo "📦 Application deployment would happen here"
    echo "WAR location: ~/nuovo-nix/deploy/commesse-0.0.1-SNAPSHOT.war"
    echo "SQL location: ~/nuovo-nix/db/gestione_commesse.sql"
  '';
}
