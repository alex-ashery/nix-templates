{ pkgs
, packages ? [ ]
, extraPackages ? [ ]
, env ? { }
, shellHook ? ""
}:

pkgs.mkShell {
  packages = packages ++ extraPackages;

  inherit env;

  shellHook = ''
    ${shellHook}
  '';
}
