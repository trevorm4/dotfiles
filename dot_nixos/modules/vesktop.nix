{ pkgs, lib, ... }: {
  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.sway.default = lib.mkForce "wlr;gtk";
  };

  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    vesktop
  ];
}
