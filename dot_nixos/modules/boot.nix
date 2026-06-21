{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  swapDevices = [
    { device = "/dev/vg0/swap"; }
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];
  boot.kernelModules = [ "nvidia_uvm" ];
}
