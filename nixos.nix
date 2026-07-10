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
  imports = [ inputs.sway-ahk.nixosModules.default ] ++ importDir ./modules;

  nixpkgs.overlays = [
    inputs.llm-agents.overlays.shared-nixpkgs
    (final: prev: {
      hunk = inputs.hunk.packages.${final.system}.hunk;
      migraine-diary = inputs.migraine-diary.packages.${final.system}.default;
      etor = final.callPackage ./pkgs/etor.nix { };
      sway-ahk = inputs.sway-ahk.packages.${final.system}.default;
    })
  ];

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
