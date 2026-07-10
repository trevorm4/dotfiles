_: {
  flake.hjemModules.web = { pkgs, ... }: {
    packages = with pkgs; [
      cargo-tauri
      librsvg
      nodejs
      pnpm
      webkitgtk_4_1
    ];
  };
}
