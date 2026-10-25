_: {
  flake.hjemModules.packages-dev = { pkgs, ... }: {
    packages = with pkgs; [
      htop
      hunk
      nixfmt
      noctalia
      quickshell
      treefmt
      unzip
      ydotool
      zellij
    ];
  };
}
