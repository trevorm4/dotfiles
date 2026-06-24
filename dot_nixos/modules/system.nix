{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    chezmoi
    eza
    home-manager
    keyd
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
    wayland.enable = true;
  };
}
