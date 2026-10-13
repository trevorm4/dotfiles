_: {
  flake.nixosModules.networking = {
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    networking.networkmanager.insertNameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
