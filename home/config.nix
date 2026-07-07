{ ... }: {
  xdg.configFile = {
    # keep-sorted start
    "nvim".source = ./config/nvim;
    "opencode".source = ./config/opencode;
    "sway".source = ./config/sway;
    "wezterm".source = ./config/wezterm;
    # keep-sorted end
  };
}
