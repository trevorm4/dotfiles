{ pkgs, ... }: {
  imports = [
    # keep-sorted start
    ./home/audio.nix
    ./home/browser.nix
    ./home/config.nix
    ./home/fish.nix
    ./home/lutris.nix
    ./home/neovim.nix
    ./home/packages.nix
    ./home/scm.nix
    ./home/starship.nix
    ./home/sway.nix
    ./home/tmux.nix
    ./home/wine.nix
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
