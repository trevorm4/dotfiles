_: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            f24 = "layer(meta)";
          };
        };
      };
    };
  };
}
