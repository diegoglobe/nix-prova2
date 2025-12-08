commesse@CSL-MDL-HP:~/nuovo-nix$ nix-instantiate --eval -E '(import ./modules/apache.nix)'
<LAMBDA>
commesse@CSL-MDL-HP:~/nuovo-nix$ nix eval --raw .#nixosConfigurations.portale-commesse.config.services.httpd.enable
warning: Git tree '/home/commesse' is dirty
error:
       … while calling the 'seq' builtin
         at «github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5?narHash=sha256-zwVvxrdIzralnSbcpghA92tWu2DV2lwv89xZc8MTrbg%3D»/lib/modules.nix:320:18:
          319|         options = checked options;
          320|         config = checked (removeAttrs config [ "_module" ]);
             |                  ^
          321|         _module = checked (config._module);

       … while calling the 'throw' builtin
         at «github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5?narHash=sha256-zwVvxrdIzralnSbcpghA92tWu2DV2lwv89xZc8MTrbg%3D»/lib/modules.nix:296:18:
          295|                     ''
          296|             else throw baseMsg
             |                  ^
          297|         else null;

       error: The option `services.httpd.enableProxy' does not exist. Definition values:
       - In `/nix/store/jnz92h9hs0cmb3zk6kdgsvgbsqbqzblc-source/nuovo-nix/modules/apache.nix': true
commesse@CSL-MDL-HP:~/nuovo-nix$ nix eval --raw .#nixosConfigurations.portale-commesse.config.services.tomcat.enable
warning: Git tree '/home/commesse' is dirty
error:
       … while calling the 'seq' builtin
         at «github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5?narHash=sha256-zwVvxrdIzralnSbcpghA92tWu2DV2lwv89xZc8MTrbg%3D»/lib/modules.nix:320:18:
          319|         options = checked options;
          320|         config = checked (removeAttrs config [ "_module" ]);
             |                  ^
          321|         _module = checked (config._module);

       … while calling the 'throw' builtin
         at «github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5?narHash=sha256-zwVvxrdIzralnSbcpghA92tWu2DV2lwv89xZc8MTrbg%3D»/lib/modules.nix:296:18:
          295|                     ''
          296|             else throw baseMsg
             |                  ^
          297|         else null;

       error: The option `services.httpd.enableProxy' does not exist. Definition values:
       - In `/nix/store/rn4c8mbsxsgqzf0nl2fq4cd11i9clqnl-source/nuovo-nix/modules/apache.nix': true
commesse@CSL-MDL-HP:~/nuovo-nix$ nix eval --raw .#nixosConfigurations.portale-commesse.config.services.mysql.enable
nix eval --raw .#nixosConfigurations.portale-commesse.config.services.mysql.enable
nix eval --raw .#nixosConfigurations.portale-commesse.config.services.mysql.enable
nix eval --raw .#nixosConfigurations.portale-commesse.config.services.mysql.enable
nix eval --raw .#nixosConfigurations.portale-commess^C
commesse@CSL-MDL-HP:~/nuovo-nix$ nix eval --raw .#nixosConfigurations.portale-commesse.config.services.mysql.enable
warning: Git tree '/home/commesse' is dirty
error:
       … while calling the 'seq' builtin
         at «github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5?narHash=sha256-zwVvxrdIzralnSbcpghA92tWu2DV2lwv89xZc8MTrbg%3D»/lib/modules.nix:320:18:
          319|         options = checked options;
          320|         config = checked (removeAttrs config [ "_module" ]);
             |                  ^
          321|         _module = checked (config._module);

       … while calling the 'throw' builtin
         at «github:NixOS/nixpkgs/205fd4226592cc83fd4c0885a3e4c9c400efabb5?narHash=sha256-zwVvxrdIzralnSbcpghA92tWu2DV2lwv89xZc8MTrbg%3D»/lib/modules.nix:296:18:
          295|                     ''
          296|             else throw baseMsg
             |                  ^
          297|         else null;

       error: The option `services.httpd.enableProxy' does not exist. Definition values:
       - In `/nix/store/qq3bi3rsjnpad7s0pv9azmck4cakkz23-source/nuovo-nix/modules/apache.nix': true
