_: {
  flake.nixosModules.sway-ahk = {
    services.sway-ahk = {
      enable = true;
      configFile = ../home/config/sway-ahk/default.yaml;
    };
  };
}
