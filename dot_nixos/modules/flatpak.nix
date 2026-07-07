{ config, pkgs, ... }:

{
  environment.sessionVariables.XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
    "/home/trevor/.local/share/flatpak/exports/share"
  ];

  services.flatpak.enable = true;

  systemd.services.flatpak-setup = let
    flatpak = "${pkgs.flatpak}/bin/flatpak";
    flathub-url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    packages = [
      "community.pathofbuilding.PathOfBuilding"
    ];
  in {
    wantedBy = [ "multi-user.target" ];
    requires = [ "flatpak.service" ];
    after = [ "flatpak.service" ];
    script = ''
      ${flatpak} remote-add --if-not-exists flathub ${flathub-url}

      for pkg in ${builtins.toString packages}; do
        installed=$(${flatpak} list --system --columns=application 2>/dev/null | grep -Fx "$pkg")
        if [ -z "$installed" ]; then
          ${flatpak} install --system --noninteractive --assumeyes flathub "$pkg"
        fi
      done
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
