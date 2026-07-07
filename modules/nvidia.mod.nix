_: {
  flake.nixosModules.nvidia = { config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = false;
    };

    environment.sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      NIXOS_OZONE_WL = "1";
      WLR_DRM_DEVICES = "/dev/dri/card1";
      WLR_NO_HARDWARE_CURSORS = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
