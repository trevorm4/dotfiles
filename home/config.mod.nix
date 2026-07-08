_: {
  flake.hjemModules.config = { lib, pkgs, ... }: {
    xdg.config.files = {
      "nvim".source = ./config/nvim;
      "opencode/opencode.json" = {
        generator = lib.generators.toJSON { };
        value = {
          "$schema" = "https://opencode.ai/config.json";
          autoupdate = false;
          permission = {
            read = {
              "/nix/store/**" = "allow";
              "~/.local/share/chezmoi/**" = "allow";
              "*" = "ask";
            };
            bash = {
              "nix *" = "allow";
              "*" = "ask";
            };
            external_directory = {
              "/nix/store/**" = "allow";
              "*" = "ask";
            };
          };
        };
      };
      "sway".source = ./config/sway;
      "wezterm".source = ./config/wezterm;
    };
  };
}
