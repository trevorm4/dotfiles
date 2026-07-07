_: {
  flake.hjemModules.packages-dev = { pkgs, ... }: {
    packages = with pkgs; [
      nixfmt
      noctalia-shell
      opencode
      quickshell
      treefmt
    ];
  };
}
