{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    bat
    chezmoi
    eza
    ffmpeg
    gh
    gpu-screen-recorder
    home-manager
    keyd
    killall
    nixfmt
    noctalia-shell
    opencode
    quickshell
    tmux
    treefmt
    vim
    vlc
    wezterm
    wget
    # keep-sorted end
  ];

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
}
