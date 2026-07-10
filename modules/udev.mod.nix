_: {
  flake.nixosModules.udev = { pkgs, ... }: {
    services.udev.packages = with pkgs; [
      via
      vial
    ];
  };
}
