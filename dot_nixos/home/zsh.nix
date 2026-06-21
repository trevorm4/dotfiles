{ ... }: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    sessionVariables = {
      EDITOR = "nvim";
      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      STARSHIP_CACHE = "$HOME/.starship/cache";
    };
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
    history = {
      path = "$HOME/.histfile";
      size = 10000;
      save = 10000;
      ignoreAllDups = true;
      findNoDups = true;
      extended = true;
    };
    initContent = ''
      for p in ~/.local/bin ~/Applications/depot_tools; do
        if [[ -d "$p" ]] && [[ ":$PATH:" != *":$p:"* ]]; then
          export PATH="$p:$PATH"
        fi
      done
      export PATH="/opt/node/bin:$PATH"

      backup() {
        if [[ -n "$1" ]]; then
          cp "$1" "$1.bak"
        else
          echo "Usage: backup <filename>"
        fi
      }
      copy() {
        local count=$#
        if [[ $count -eq 2 ]] && [[ -d "$1" ]]; then
          local from="''${1%/}"
          local to="$2"
          command cp -r "$from" "$to"
        else
          command cp "$@"
        fi
      }
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      extract() {
        local file="$1"
        if [[ -f "$file" ]]; then
          case "$file" in
            *.tar.bz2) tar xjf "$file" ;;
            *.tar.gz) tar xzf "$file" ;;
            *.bz2) bunzip2 "$file" ;;
            *.rar) unrar x "$file" ;;
            *.gz) gunzip "$file" ;;
            *.tar) tar xvf "$file" ;;
            *.tbz2) tar xjf "$file" ;;
            *.tgz) tar xzf "$file" ;;
            *.zip) unzip "$file" ;;
            *.Z) uncompress "$file" ;;
            *.7z) 7z x "$file" ;;
            *) echo "'$file' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$file' is not a valid file"
        fi
      }

      zstyle :compinstall filename "$HOME/.zshrc"
      . "$HOME/.atuin/bin/env"
      eval "$(atuin init zsh)"
      source /usr/share/nvm/init-nvm.sh
    '';
  };
}
