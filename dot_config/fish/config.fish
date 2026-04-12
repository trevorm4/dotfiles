set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -x PATH /opt/node/bin $PATH
set -x PATH ~/.cargo/bin $PATH

set -Ux __NV_DISABLE_EXPLICIT_SYNC 1
set -U nvm_default_version latest

for p in ~/.local/bin ~/Applications/depot_tools
    if test -d $p; and not contains $p $PATH
        set -x PATH $p $PATH
    end
end

set -x EDITOR vim
set fish_greeting

function backup
    if test (count $argv) -eq 1
        cp $argv[1] $argv[1].bak
    else
        echo "Usage: backup <filename>"
    end
end

function copy
    set count (count $argv)
    if test $count -eq 2; and test -d $argv[1]
        set from (string trim --right --chars=/ $argv[1])
        set to $argv[2]
        command cp -r $from $to
    else
        command cp $argv
    end
end

function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end

function extract
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
end

function t
    set session (sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    if test -n "$session"
        sesh connect $session
    end
end

function kill_pattern
    ps aux | grep -E "$argv[1]" | awk '{ print $2 }' | xargs kill -9
end

alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.='eza -a | grep -e "^\."'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias update='sudo pacman -Syu'
alias mirror="sudo cachyos-rate-mirrors"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias jctl="journalctl -p 3 -xb"
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

starship init fish | source

