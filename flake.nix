{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  description = "My personal collection of Nix templates";

  outputs = { self, nixpkgs, flake-utils, ... }: {

    templates = {
      default = self.templates.base;

      base = {
        path = ./templates/base;
        description = "Base template for new repos";
      };

      go = {
        path = ./templates/go;
        description = "Go repo with Nix devshell";
      };

      python-uv = {
        path = ./templates/python-uv;
        description = "Python repo using uv with Nix devshell";
      };
    };
  }
  // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { system = system; };
    in
    {
      lib = {
        mkBaseShell = import ./lib/base.nix;
        mkGoShell = import ./lib/go.nix;
        mkPythonUvShell = import ./lib/python-uv.nix;
      };

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
