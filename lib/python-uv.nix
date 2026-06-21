{ pkgs
, extraPackages ? [ ]
, pythonPackage ? pkgs.python312
, shellHook ? ""
}:

import ./base.nix {
  inherit pkgs extraPackages;

  packages = with pkgs; [
    pythonPackage
    uv
    ruff
    pyright
  ];

  shellHook = ''
    export UV_PROJECT_ENVIRONMENT="$PWD/.venv"
    export VIRTUAL_ENV="$PWD/.venv"
    export PATH="$VIRTUAL_ENV/bin:$PATH"

    ${shellHook}
  '';
}
