_: {
  flake.nixosModules.audio = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  flake.hjemModules.audio = { pkgs, ... }: {
    packages = with pkgs; [
      easyeffects
    ];
  };
}
