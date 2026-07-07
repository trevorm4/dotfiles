{ pkgs, ... }: {
  imports = [
    # keep-sorted start
    ./home/fish.nix
    ./home/lutris.nix
    ./home/starship.nix
    ./home/tmux.nix
    ./home/zsh.nix
    # keep-sorted end
  ];

  home = {
    username = "trevor";
    homeDirectory = "/home/trevor";

    stateVersion = "26.05";
    pointerCursor = {
      name = "catppuccin-mocha-mauve-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
