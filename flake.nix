{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  description = "My personal collection of flake templates";

  outputs = { self, nixpkgs, flake-utils, ... }: {

    templates = {
      base = {
        path = ./base;
        description = "Base template for new repos";
      };
    };

    defaultTemplate = self.templates.base;

    
  }
  // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { system = system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = import ./.packages.nix { inherit pkgs; };
        shellHook = ''
          if [ -d .git ]; then
            pre-commit install --install-hooks --hook-type pre-commit
          fi
        '';
      };
    }
  );
}
