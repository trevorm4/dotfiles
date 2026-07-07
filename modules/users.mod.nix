_: {
  flake.nixosModules.users = { pkgs, ... }: {
    programs.fish.enable = true;

    users.users.trevor = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      initialPassword = "changeme";
    };
  };
}
