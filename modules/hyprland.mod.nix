_: {
  flake.nixosModules.hyprland = {
    # nixpkgs-unstable carries the latest upstream release (0.56.2).
    programs.hyprland = {
      enable = true;
      # Plain session like sway (no uwsm); systemd env import is handled
      # by hyprland.lua on startup.
      withUWSM = false;
    };
  };

  flake.hjemModules.hyprland = { pkgs, ... }: {
    packages = with pkgs; [
      grim
      hypridle
      hyprlock
      hyprshutdown
      slurp
      swappy
      wl-clipboard
      xclip
    ];
  };
}
