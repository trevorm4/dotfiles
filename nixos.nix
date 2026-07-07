{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # keep-sorted start
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/file-manager.nix
    ./modules/flatpak.nix
    ./modules/fonts.nix
    ./modules/hardware.nix
    ./modules/keyd.nix
    ./modules/networking.nix
    ./modules/nvidia.nix
    ./modules/steam.nix
    ./modules/sway.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/xdg.nix
    # keep-sorted end
  ];

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
