{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nix-templates = {
      url = "github:alex-ashery/nix-templates";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { nixpkgs, flake-utils, nix-templates, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { system = system; };
      in
      {
        devShells.default = nix-templates.lib.${system}.mkBaseShell {
          inherit pkgs;
          extraPackages = import ./.packages.nix { inherit pkgs; };
          shellHook = ''
            if [ -d .git ]; then
              pre-commit install --install-hooks --hook-type pre-commit
            fi
          '';
        };
      }
    );
}
