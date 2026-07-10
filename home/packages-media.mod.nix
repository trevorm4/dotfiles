_: {
  flake.hjemModules.packages-media = { pkgs, ... }: {
    packages = with pkgs; [
      ffmpeg
      gpu-screen-recorder
      spotify
      vlc
    ];
  };
}
