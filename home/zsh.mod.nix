_: {
  flake.hjemModules.zsh = {
    programs.zsh = {
      enable = true;
      initConfig = ''
        ZSH_DISABLE_COMPFIX=true

        bindkey -v

        HISTFILE=$HOME/.histfile
        HISTSIZE=10000
        SAVEHIST=10000
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_FIND_NO_DUPS
        setopt EXTENDED_HISTORY

        export EDITOR=nvim
        export MANROFFOPT="-c"
        export MANPAGER="sh -c 'col -bx | bat -l man -p'"
        export STARSHIP_CACHE="$HOME/.starship/cache"

        alias ls='eza -al --color=always --group-directories-first --icons'
        alias la='eza -a --color=always --group-directories-first --icons'
        alias ll='eza -l --color=always --group-directories-first --icons'
        alias lt='eza -aT --color=always --group-directories-first --icons'
        alias 'l.'='eza -a | grep -e "^\."'
        alias '..'='cd ..'
        alias '...'='cd ../..'
        alias '....'='cd ../../..'
        alias '.....'='cd ../../../..'
        alias '......'='cd ../../../../..'
        alias fixpacman='sudo rm /var/lib/pacman/db.lck'
        alias tarnow='tar -acf'
        alias untar='tar -zxvf'
        alias wget='wget -c'
        alias psmem='ps auxf | sort -nr -k 4'
        alias psmem10='ps auxf | sort -nr -k 4 | head -10'
        alias big='''expac -H M '''%m\t%n''' | sort -h | nl'
        alias gitpkg='pacman -Q | grep -i "-git" | wc -l'
        alias update='sudo pacman -Syu'
        alias mirror='sudo cachyos-rate-mirrors'
        alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
        alias apt='man pacman'
        alias apt-get='man pacman'
        alias please='sudo'
        alias jctl='journalctl -p 3 -xb'
        alias nf='neofetch'
        alias ff='fastfetch'
        alias uf='uwufetch'
        alias q='exit'
        alias h='history'
        alias c='clear'
        alias k='kubectl'
        alias kctx='kubectx'
        alias gs='git status'
        alias ga='git add'
        alias gc='git commit'
        alias gcl='git clone'
        alias gl='git log --oneline'
        alias gd='git diff'
        alias gpush='git push'
        alias gpull='git pull'
        alias wifi='nmtui'
        alias install='yay -S'
        alias search='yay -Ss'
        alias lsearch='yay -Qs'
        alias remove='yay -Rns'
        alias shutdown='systemctl poweroff'
        alias du='dust'
        alias cz='chezmoi'

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
  };
}
