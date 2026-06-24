{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.trevor = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialPassword = "changeme";
  };
}
