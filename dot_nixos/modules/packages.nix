{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    chezmoi
    easyeffects
    eza
    starship
    git
    firefox
    helium
    fish
    home-manager
    keyd
    nixfmt
    opencode
    vim
    quickshell
    noctalia-shell
    tmux
    vesktop
    wezterm
    wget
  ];

  services.displayManager.sddm = {
    enable = true;

    # Enables experimental Wayland support
    wayland.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
}
