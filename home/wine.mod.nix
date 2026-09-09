_: {
  flake.hjemModules.wine = { pkgs, ... }: {
    packages = with pkgs; [
      (wineWow64Packages.full.override {
        mingwSupport = true;
        wineRelease = "staging";
      })
      winetricks
    ];
  };
}
