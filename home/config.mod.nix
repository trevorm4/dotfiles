_: {
  flake.hjemModules.config = { ... }: {
    files.".agents/skills".source = ./config/skills;

    xdg.config.files = {
      "hypr".source = ./config/hypr;
      "nvim".source = ./config/nvim;
      "sway".source = ./config/sway;
      "sway-ahk".source = ./config/sway-ahk;
      "wezterm".source = ./config/wezterm;
      "zellij".source = ./config/zellij;
    };
  };
}
