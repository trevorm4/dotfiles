_: {
  flake.hjemModules.config = { ... }: {
    xdg.config.files = {
      "nvim".source = ./config/nvim;
      "sway".source = ./config/sway;
      "wezterm".source = ./config/wezterm;
    };
  };
}
