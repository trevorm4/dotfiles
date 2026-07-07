_: {
  flake.nixosModules.boot =
    {
      config,
      lib,
      modulesPath,
      pkgs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        initrd = {
          kernelModules = [ "dm-snapshot" ];
          availableKernelModules = [
            "ahci"
            "nvme"
            "sd_mod"
            "usb_storage"
            "usbhid"
            "xhci_pci"
          ];
        };

        loader = {
          systemd-boot = {
            configurationLimit = 10;
            enable = true;
          };
          efi.canTouchEfiVariables = true;
          grub.efiSupport = true;
          efi.efiSysMountPoint = "/boot";
        };

        kernelPackages = pkgs.linuxPackages_latest;
        kernelParams = [
          "nvidia_drm.modeset=1"
          "split_lock_detect=off"
        ];
        kernelModules = [
          "kvm-amd"
          "nvidia_uvm"
        ];
      };

      fileSystems."/" = {
        device = "/dev/mapper/vg0-nixos";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/0ECC-E769";
        fsType = "vfat";
        options = [
          "dmask=0022"
          "fmask=0022"
        ];
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      swapDevices = [
        { device = "/dev/vg0/swap"; }
      ];
    };
}
