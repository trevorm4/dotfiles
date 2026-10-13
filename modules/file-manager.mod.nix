_: {
  flake.nixosModules.file-manager = {
    programs.thunar.enable = true;
    services.udisks2.enable = true;
  };
}
