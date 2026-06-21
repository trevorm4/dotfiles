{ pkgs, ... }: {
  imports = [
    ./home/starship.nix
    ./home/ghostty.nix
    ./home/tmux.nix
    ./home/zsh.nix
    ./home/fish.nix
  ];

  home.username = "trevor";
  home.homeDirectory = "/home/trevor";
  home.stateVersion = "26.05";

  home.pointerCursor = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
