_: {
  flake.hjemModules.pi = { pkgs, ... }: {
    packages = [ pkgs.llm-agents.pi ];
  };
}
