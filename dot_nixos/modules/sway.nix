{ pkgs, ... }: {
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  environment.systemPackages = with pkgs; [
    grim
    slurp
    swappy
  ];
}
