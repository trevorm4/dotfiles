_: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons";
      la = "eza -a --color=always --group-directories-first --icons";
      ll = "eza -l --color=always --group-directories-first --icons";
      lt = "eza -aT --color=always --group-directories-first --icons";
      "l." = ''eza -a | grep -e "^\."'';
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      fixpacman = "sudo rm /var/lib/pacman/db.lck";
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      wget = "wget -c ";
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";
      big = ''expac -H M '%m\t%n' | sort -h | nl'';
      gitpkg = ''pacman -Q | grep -i "\-git" | wc -l'';
      update = "sudo pacman -Syu";
      mirror = "sudo cachyos-rate-mirrors";
      cleanup = "sudo pacman -Rns $(pacman -Qtdq)";
      apt = "man pacman";
      "apt-get" = "man pacman";
      please = "sudo";
      jctl = "journalctl -p 3 -xb";
      nf = "neofetch";
      ff = "fastfetch";
      uf = "uwufetch";
      q = "exit";
      h = "history";
      c = "clear";
      k = "kubectl";
      kctx = "kubectx";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gcl = "git clone";
      gl = "git log --oneline";
      gd = "git diff";
      gpush = "git push";
      gpull = "git pull";
      wifi = "nmtui";
      install = "yay -S";
      search = "yay -Ss";
      lsearch = "yay -Qs";
      remove = "yay -Rns";
      shutdown = "systemctl poweroff";
      du = "dust";
      cz = "chezmoi";
    };
    functions = {
      backup = "cp $argv[1] $argv[1].bak";
      copy = ''
        set count (count $argv)
        if test $count -eq 2; and test -d $argv[1]
          set from (string trim --right --chars=/ $argv[1])
          set to $argv[2]
          command cp -r $from $to
        else
          command cp $argv
        end
      '';
      mkcd = "mkdir -p $argv[1]; and cd $argv[1]";
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
      t = ''
        set session (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
        if test -n "$session"
          sesh connect $session
        end
      '';
      kill_pattern = "ps aux | grep -E $argv[1] | awk '{ print $2 }' | xargs kill -9";
    };
    shellInit = ''
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
}
