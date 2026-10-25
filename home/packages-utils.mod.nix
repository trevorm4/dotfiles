_: {
  flake.hjemModules.packages-utils = { pkgs, ... }: {
    packages = with pkgs; [
      bat
      direnv
      eza
      dust
      killall
      tmux
      discord
      vesktop
      vim
      watchman
      wezterm
      wget
    ];
  };
}
