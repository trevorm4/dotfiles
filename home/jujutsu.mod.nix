_: {
  flake.hjemModules.jujutsu = { lib, pkgs, ... }: {
    packages = [ pkgs.jujutsu ];

    xdg.config.files."jj/config.toml" = {
      generator = pkgs.writers.writeTOML "jj-config.toml";
      value = {
        user = {
          name = "Trevor";
          email = "trevorm4swe@gmail.com";
        };

        aliases = {
          ".." = [
            "edit"
            "@-"
          ];
          ",," = [
            "edit"
            "@+"
          ];
          f = [
            "git"
            "fetch"
          ];
          p = [
            "git"
            "push"
          ];
          a = [ "abandon" ];
          c = [ "commit" ];
          d = [ "diff" ];
          e = [ "edit" ];
          l = [ "log" ];
          r = [ "rebase" ];
          res = [ "resolve" ];
          s = [ "squash" ];
          sh = [ "show" ];
          u = [ "undo" ];
        };

        revsets.bookmark-advance-to = ''
          heads(::@ & ~description(exact:"") & (~empty() | merges()))
        '';

        revsets.log = ''
          present(@) | present(trunk()) | ancestors(remote_bookmarks().. | @.., 8)
        '';

        ui.default-command = "log";
        ui.diff-editor = ":builtin";
        ui.conflict-marker-style = "snapshot";

        git.fetch = [ "origin" ];
        git.push = "origin";

        signing.behavior = "drop";
      };
    };
  };
}
