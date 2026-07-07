_: {
  flake.hjemModules.config = {
    xdg.config.files = {
      # keep-sorted start
      "nvim".source = ./config/nvim;
      "opencode/opencode.json".source = ./config/opencode/opencode.json;
      "sway".source = ./config/sway;
      "wezterm".source = ./config/wezterm;
      # keep-sorted end
    };
  };
}
