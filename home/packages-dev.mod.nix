_: {
  flake.hjemModules.packages-dev = { pkgs, ... }: {
    packages = with pkgs; [
      htop
      hunk
      nixfmt
      noctalia-shell
      opencode
      quickshell
      treefmt
      unzip
      ydotool
      zellij
    ];
  };
}
