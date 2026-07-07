_: {
  flake.hjemModules.packages-utils = { pkgs, ... }: {
    packages = with pkgs; [
      bat
      eza
      killall
      tmux
      vesktop
      vim
      wezterm
      wget
    ];
  };
}
