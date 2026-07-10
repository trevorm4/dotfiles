_: {
  flake.nixosModules.users = { pkgs, ... }: {
    programs.fish.enable = true;

    users.users.trevor = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [
        "input"
        "networkmanager"
        "wheel"
      ];
      initialPassword = "changeme";
    };
  };
}
