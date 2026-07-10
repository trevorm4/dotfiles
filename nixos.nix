{ inputs, ... }:
let
  importModule =
    name: dir:
    (import (dir + "/${name}") { })
    .flake.nixosModules.${builtins.replaceStrings [ ".mod.nix" ] [ "" ] name};

  importDir =
    dir:
    builtins.map (name: importModule name dir) (
      builtins.filter (f: builtins.match ".*\\.mod\\.nix" f != null) (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  importHjemDir =
    dir:
    builtins.filter (x: x != null) (
      builtins.map
        (
          name:
          let
            mod = import (dir + "/${name}") { };
            modName = builtins.replaceStrings [ ".mod.nix" ] [ "" ] name;
          in
          if mod ? flake.hjemModules && builtins.hasAttr modName mod.flake.hjemModules then
            mod.flake.hjemModules.${modName}
          else
            null
        )
        (
          builtins.filter (f: builtins.match ".*\\.mod\\.nix" f != null) (
            builtins.attrNames (builtins.readDir dir)
          )
        )
    );
in
{
  imports = importDir ./modules;

  hjem.users.trevor = {
    imports = [
      inputs.hjem-rum.hjemModules.hjem-rum
      ./home.nix
    ]
    ++ importHjemDir ./modules;
  };

  time.timeZone = "America/Los_Angeles";
  system.stateVersion = "26.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
}
