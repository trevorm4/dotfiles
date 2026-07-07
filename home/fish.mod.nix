_:
let
  aliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";
    "l." = "eza -a | grep -e \"^.\"";
    apt = "man pacman";
    "apt-get" = "man pacman";
    big = "expac -H M '%m\t%n' | sort -h | nl";
    c = "clear";
    cat = "bat";
    cleanup = "sudo pacman -Rns $(pacman -Qtdq)";
    cz = "chezmoi";
    du = "dust";
    ff = "fastfetch";
    fixpacman = "sudo rm /var/lib/pacman/db.lck";
    ga = "git add";
    gc = "git commit";
    gcl = "git clone";
    gd = "git diff";
    gitpkg = "pacman -Q | grep -i \"-git\" | wc -l";
    gl = "git log --oneline";
    gpull = "git pull";
    gpush = "git push";
    gs = "git status";
    h = "history";
    install = "yay -S";
    jctl = "journalctl -p 3 -xb";
    k = "kubectl";
    kctx = "kubectx";
    la = "eza -a --color=always --group-directories-first --icons";
    ll = "eza -l --color=always --group-directories-first --icons";
    ls = "eza -al --color=always --group-directories-first --icons";
    lsearch = "yay -Qs";
    lt = "eza -aT --color=always --group-directories-first --icons";
    mirror = "sudo cachyos-rate-mirrors";
    nf = "neofetch";
    please = "sudo";
    psmem = "ps auxf | sort -nr -k 4";
    psmem10 = "ps auxf | sort -nr -k 4 | head -10";
    q = "exit";
    remove = "yay -Rns";
    search = "yay -Ss";
    shutdown = "systemctl poweroff";
    tarnow = "tar -acf ";
    uf = "uwufetch";
    untar = "tar -zxvf ";
    update = "sudo pacman -Syu";
    wget = "wget -c ";
    wifi = "nmtui";
  };
in
{
  flake.hjemModules.fish = {
    programs.fish = {
      enable = true;
      inherit aliases;
      functions = {
        extract = ''
          set file $argv[1]
          if test -f $file
            switch $file
              case '*.tar.bz2'
                tar xjf $file
              case '*.tar.gz'
                tar xzf $file
              case '*.bz2'
                bunzip2 $file
              case '*.rar'
                unrar x $file
              case '*.gz'
                gunzip $file
              case '*.tar'
                tar xvf $file
              case '*.tbz2'
                tar xjf $file
              case '*.tgz'
                tar xzf $file
              case '*.zip'
                unzip $file
              case '*.Z'
                uncompress $file
              case '*.7z'
                7z x $file
              case '*'
                echo "'$file' cannot be extracted via extract()"
            end
          else
            echo "'$file' is not a valid file"
          end
        '';
        kill_pattern = "ps aux | grep -E $argv[1] | awk '{ print $2 }' | xargs kill -9";
        t = ''
          set session (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
          if test -n "$session"
            sesh connect $session
          end
        '';
      };
      config = ''
        set -x MANROFFOPT "-c"
        set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
        set -x PATH /opt/node/bin $PATH ~/.cargo/bin
        set -x __NV_DISABLE_EXPLICIT_SYNC 1
        set -x nvm_default_version latest
        for p in ~/.local/bin ~/Applications/depot_tools
            if test -d $p; and not contains $p $PATH
                set -x PATH $p $PATH
            end
        end
        set -x EDITOR vim
        set fish_greeting
      '';
    };
  };
}
