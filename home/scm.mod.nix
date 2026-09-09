_: {
  flake.hjemModules.scm = { pkgs, ... }: {
    packages = with pkgs; [
      gh
      git
      jjui
      jujutsu
    ];
  };
}
