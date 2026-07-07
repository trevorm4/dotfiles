{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    chezmoi
    eza
    gpu-screen-recorder
    home-manager
    keyd
    killall
    nixfmt
    opencode
    vim
    quickshell
    noctalia-shell
    tmux
    ffmpeg
    wezterm
    wget
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
