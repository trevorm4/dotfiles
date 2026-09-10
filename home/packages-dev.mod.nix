_: {
  flake.hjemModules.packages-dev = { pkgs, ... }: {
    packages = with pkgs; [
      nixfmt
      noctalia-shell
      llm-agents.opencode
      quickshell
      treefmt
      zellij
    ];
  };
}
