{ ... }: {
  perSystem = { pkgs, ... }: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt.enable = true;
      programs.keep-sorted.enable = true;
    };
  };
}
