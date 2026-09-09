_: {
  flake.hjemModules.starship = {
    programs.starship = {
      enable = true;
      integrations = {
        fish.enable = true;
        zsh.enable = true;
      };
      settings = {
        format = "$directory$character";
      };
    };
  };
}
