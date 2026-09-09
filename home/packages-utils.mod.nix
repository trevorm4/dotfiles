_: {
  flake.hjemModules.packages-utils = { pkgs, ... }: {
    packages = with pkgs; [
      bat
      direnv
      eza
      dust
      killall
      tmux
      vesktop
      vim
      watchman
      wezterm
      wget
    ];
  };
}
