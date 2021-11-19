{
  description = "A very basic flake";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree
          {
            template-nix-nim = pkgs.nimPackages.buildNimPackage {
              name = "template_nix_nim";
              src = ./.;
            };
          };
        defaultPackage = packages.template-nix-nim;
        apps.template-nix-nim = flake-utils.lib.mkApp { drv = packages.template-nix-nim; };
        defaultApp = apps.template-nix-nim;
        devShell = pkgs.callPackage ./shell.nix { };
      }
    );
}
