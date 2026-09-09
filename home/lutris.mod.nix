_: {
  flake.hjemModules.lutris = { pkgs, ... }: {
    packages = with pkgs; [
      gamescope
      lutris
      umu-launcher
    ];

    xdg.data.files."Steam/compatibilitytools.d/GE-Proton" = {
      source = pkgs.proton-ge-bin.steamcompattool;
    };
  };
}
