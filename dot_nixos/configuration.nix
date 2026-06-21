{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/nvidia.nix
    ./modules/keyd.nix
    ./modules/audio.nix
    ./modules/users.nix
    ./modules/jujutsu.nix
    ./modules/fish.nix
    ./modules/sway.nix
    ./modules/neovim.nix
    ./modules/fonts.nix
    ./modules/steam.nix
    ./modules/packages.nix
  ];

  time.timeZone = "America/Los_Angeles";
  system.stateVersion = "26.05";
}
