{ pkgs
, extraPackages ? [ ]
, pythonPackage ? pkgs.python312
, shellHook ? ""
}:

pkgs.mkShell {
  packages = with pkgs; [
    pythonPackage
    uv
    ruff
    pyright
    just
  ] ++ extraPackages;

  shellHook = ''
    export UV_PROJECT_ENVIRONMENT="$PWD/.venv"
    export VIRTUAL_ENV="$PWD/.venv"
    export PATH="$VIRTUAL_ENV/bin:$PATH"

    ${shellHook}
  '';
}
