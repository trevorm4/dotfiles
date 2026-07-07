_: {
  flake.nixosModules.system = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = false;
      settings = {
        General = {
          HaltCommand = "/run/current-system/sw/bin/systemctl poweroff";
          RebootCommand = "/run/current-system/sw/bin/systemctl reboot";
        };
      };
    };

    services.xserver.enable = true;
  };
}
