_: {
  flake.nixosModules.sway = {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraOptions = [ "--unsupported-gpu" ];
    };
  };

  flake.hjemModules.sway = { pkgs, ... }: {
    packages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };
}
