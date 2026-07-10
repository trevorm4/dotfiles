_: {
  flake.hjemModules.config = { ... }: {
    xdg.config.files = {
      "nvim".source = ./config/nvim;
      "sway".source = ./config/sway;
      "sway-ahk".source = ./config/sway-ahk;
      "wezterm".source = ./config/wezterm;
      "zellij".source = ./config/zellij;
    };
  };
}
