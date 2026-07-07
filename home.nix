{ lib, ... }:
let
  inherit (lib.modules) mkAliasOptionModule;

  importHjem =
    name: dir:
    (import (dir + "/${name}") { })
    .flake.hjemModules.${builtins.replaceStrings [ ".mod.nix" ] [ "" ] name};

  importDir =
    dir:
    builtins.map (name: importHjem name dir) (
      builtins.filter (f: builtins.match ".*\\.mod\\.nix" f != null) (
        builtins.attrNames (builtins.readDir dir)
      )
    );
in
{
  imports = [
    (mkAliasOptionModule [ "programs" ] [ "rum" "programs" ])
  ]
  ++ importDir ./home;
}
