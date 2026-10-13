_: {
  flake.hjemModules.apps = { pkgs, ... }: {
    packages = with pkgs; [
      etor
      migraine-diary
      vial
    ];
  };
}
