{ lib, ... }:
let
  discover =
    dir:
    builtins.map (f: dir + "/${f}") (
      builtins.filter (f: builtins.match ".*\\.mod\\.nix" f != null) (
        builtins.attrNames (builtins.readDir dir)
      )
    );
in
{
  options.flake.hjemModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
  };

  imports = discover ./../modules ++ discover ./../home;
}
