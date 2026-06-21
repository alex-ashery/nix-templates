{ pkgs
, extraPackages ? [ ]
, goPackage ? pkgs.go
, shellHook ? ""
}:

import ./base.nix {
  inherit pkgs extraPackages;

  packages = with pkgs; [
    goPackage
    gopls
    delve
    golangci-lint
    gotools
    go-tools
  ];

  shellHook = ''
    mkdir -p .go/bin .go/pkg .go/cache

    export GOPATH="$PWD/.go"
    export GOBIN="$PWD/.go/bin"
    export GOCACHE="$PWD/.go/cache"
    export PATH="$GOBIN:$PATH"

    ${shellHook}
  '';
}
