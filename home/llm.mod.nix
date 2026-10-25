_: {
  flake.hjemModules.llm = { pkgs, ... }: {
    packages = [ pkgs.llm-agents.pi ];
  };
}
