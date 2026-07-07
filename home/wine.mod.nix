_: {
  flake.hjemModules.wine = { pkgs, ... }: {
    packages = with pkgs; [
      (wineWowPackages.full.override {
        mingwSupport = true;
        wineRelease = "staging";
      })
      winetricks
    ];
  };
}
