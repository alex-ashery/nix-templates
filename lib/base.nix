{ pkgs
, packages ? [ ]
, extraPackages ? [ ]
, env ? { }
, shellHook ? ""
}:

pkgs.mkShell {
  packages = (with pkgs; [
    pre-commit
    just
  ]) ++ packages ++ extraPackages;

  inherit env;

  shellHook = ''
    ${shellHook}
  '';
}
