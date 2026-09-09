_: {
  flake.hjemModules.opencode =
    { lib, pkgs, ... }:
    let
      inherit (lib.attrsets) genAttrs;
      inherit (lib.trivial) const;
      inherit (lib.lists) singleton;
      inherit (lib.strings) concatLines;

      allowed.commands = [
        "rg*"
        "ls*"
        "head*"
        "tail*"
        "find*"
        "cat*"
        "echo*"
        "grep*"
        "timeout*"

        "jj bookmark list*"
        "jj config get*"
        "jj config list*"
        "jj config path*"
        "jj diff*"
        "jj evolog*"
        "jj file annotate*"
        "jj file list*"
        "jj file search*"
        "jj file show*"
        "jj file track*"
        "jj git colocation status*"
        "jj git remote list*"
        "jj git root*"
        "jj help*"
        "jj interdiff*"
        "jj log*"
        "jj op diff*"
        "jj op log*"
        "jj op show*"
        "jj operation diff*"
        "jj operation log*"
        "jj operation show*"
        "jj resolve --list"
        "jj root*"
        "jj show*"
        "jj sparse list*"
        "jj st*"
        "jj status*"
        "jj tag list*"
        "jj util completion*"
        "jj util config-schema*"
        "jj util markdown-help*"
        "jj version*"
        "jj workspace list*"
        "jj workspace root*"

        "gh auth status*"
        "gh cache list*"
        "gh gist list*"
        "gh gist view*"
        "gh issue list*"
        "gh issue status*"
        "gh issue view*"
        "gh label list*"
        "gh pr checks*"
        "gh pr diff*"
        "gh pr list*"
        "gh pr status*"
        "gh pr view*"
        "gh release list*"
        "gh release view*"
        "gh repo list*"
        "gh repo view*"
        "gh ruleset check*"
        "gh ruleset list*"
        "gh ruleset view*"
        "gh run list*"
        "gh run view*"
        "gh search *"
        "gh status*"
        "gh variable get*"
        "gh variable list*"
        "gh workflow list*"
        "gh workflow view*"

        "cargo clippy*"
        "cargo nextest*"

        "nix *"
        "nix3 *"
      ];

      forbidden.commands = [
        {
          command = "git*";
          justification = "Use `jj` for version control.";
        }
        {
          command = "cargo check*";
          justification = "Use `cargo clippy` instead of `cargo check`.";
        }
        {
          command = "cargo test*";
          justification = "Use `cargo nextest` instead of `cargo test`.";
        }
      ];

      instructions = concatLines (
        map (instruction: "- ${instruction}") (
          [
            "Use `nix flake check`."
            "Use `nix flake show`."
            "Prefer nix3 commands over nix2 commands."
          ]
          ++ map ({ justification, ... }: justification) forbidden.commands
        )
      );

      allowed.paths = [
        "/etc/profiles"
        "/nix/store"
        "~/"
      ];
    in
    {
      xdg.config.files."opencode/opencode.json" = {
        generator = lib.generators.toJSON { };
        value = {
          "$schema" = "https://opencode.ai/config.json";

          autoupdate = false;

          instructions = singleton "${pkgs.writeText "instructions.md" instructions}";

          permission = {
            "*" = "ask";
            codesearch = "allow";
            external_directory = genAttrs (map (path: "${path}/**") allowed.paths) (const "allow");
            glob = "allow";
            grep = "allow";
            list = "allow";
            lsp = "allow";
            read = "allow";
            task = "allow";
            todoread = "allow";
            todowrite = "allow";
            webfetch = "allow";
            websearch = "allow";

            bash =
              { }
              // genAttrs allowed.commands (const "allow")
              // genAttrs (map ({ command, ... }: command) forbidden.commands) (const "deny");
          };
        };
      };

      xdg.config.files."opencode/tui.json" = {
        generator = lib.generators.toJSON { };
        value = {
          "$schema" = "https://opencode.ai/tui.json";
          theme = "system";
        };
      };
    };
}
