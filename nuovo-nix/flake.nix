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
          
          # Node.js 20 + npm + Angular CLI
          nodejs_20
          nodePackages.npm
          nodePackages.angular-cli
          
          # MariaDB 10.4
          mariadb
          mariadb-client
          
          # Tomcat 10
          tomcat10
          
          # Utilità base
          git
          curl
        ];
      };
    };
}
