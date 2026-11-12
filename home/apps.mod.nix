_: {
  flake.hjemModules.apps = { pkgs, ... }: {
    packages = with pkgs; [
     (symlinkJoin {
        name = "awakened-poe-trade-x11";
        paths = [ awakened-poe-trade ];
        nativeBuildInputs = [ makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/awakened-poe-trade --add-flags "--ozone-platform=x11"
        '';
      })
      etor
      migraine-diary
      pd2-trade
      vial
    ];
  };
}
