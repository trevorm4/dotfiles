_: {
  flake.nixosModules.hardware =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      hardware = {
        cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            libva-vdpau-driver
            nvidia-vaapi-driver
          ];
        };
      };
    };
}
