{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Java 21
          jdk21
          
          # Node.js 20 (Angular 15 funziona con Node 18-20)
          nodejs_20
          
          # Angular CLI
          nodePackages."@angular/cli"
          
          # MariaDB (la versione disponibile, sarà 10.4+)
          mariadb
          mariadb-client
          
          # Tomcat 10
          tomcat10
          
          # Apache 2.4
          apacheHttpd
          
          # Utilità
          git
          curl
        ];
      };
    };
}
