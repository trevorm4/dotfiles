_: {
  flake.hjemModules.apps = { pkgs, ... }: {
    packages = with pkgs; [
      etor
      migraine-diary
      pd2-trade
      vial
    ];
  };
}
