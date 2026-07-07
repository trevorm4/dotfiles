{ pkgs, ... }: {
  programs.lutris = {
    enable = true;
    winePackages = with pkgs; [
      wineWowPackages.full
    ];
    protonPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      umu-launcher
    ];
  };

  home.packages = with pkgs; [
    gamescope
  ];

  xdg.dataFile."Steam/compatibilitytools.d/GE-Proton" = {
    source = pkgs.proton-ge-bin.steamcompattool;
  };
}
