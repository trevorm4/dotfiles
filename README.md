Hi I'm Trevor and these are my NixOS configs.

A flake built with [flake-parts](https://flakeparts.dev). System modules live in `modules/` and home modules in `home/` — both are auto-imported from any `*.mod.nix` file. Local packages are in `pkgs/`, flake wiring in `parts/`.

Rebuild with `nixos-rebuild switch --flake .`
