_: {
  flake.hjemModules.rust = { pkgs, ... }: {
    packages = with pkgs; [
      gcc
      openssl
      pkg-config
      rustup
    ];

    environment.sessionVariables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };
}
