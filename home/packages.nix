{ pkgs, ... }: {
  home.packages = with pkgs; [
    # keep-sorted start
    bat
    eza
    ffmpeg
    gpu-screen-recorder
    killall
    nixfmt
    noctalia-shell
    opencode
    quickshell
    tmux
    treefmt
    vesktop
    vim
    vlc
    wezterm
    wget
    # keep-sorted end
  ];
}
