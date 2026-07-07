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
in
{
  imports = importDir ./modules;

  hjem.users.trevor = {
    imports = [
      inputs.hjem-rum.hjemModules.hjem-rum
      ./home.nix
    ];
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
