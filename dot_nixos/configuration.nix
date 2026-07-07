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
    ./modules/browser.nix
    ./modules/file-manager.nix
    ./modules/flatpak.nix
    ./modules/fonts.nix
    ./modules/hardware.nix
    ./modules/jujutsu.nix
    ./modules/keyd.nix
    ./modules/neovim.nix
    ./modules/networking.nix
    ./modules/nvidia.nix
    ./modules/steam.nix
    ./modules/sway.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/vesktop.nix
    ./modules/wine.nix
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
