{ config, lib, pkgs, ... }: {
  imports = [
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/nvidia.nix
    ./modules/hardware.nix
    ./modules/keyd.nix
    ./modules/audio.nix
    ./modules/users.nix
    ./modules/jujutsu.nix
    ./modules/sway.nix
    ./modules/neovim.nix
    ./modules/fonts.nix
    ./modules/steam.nix
    ./modules/browser.nix
    ./modules/system.nix
    ./modules/vesktop.nix
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
