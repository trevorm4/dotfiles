_: {
  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = "a";
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    historyLimit = 1000000;
    focusEvents = true;
    disableConfirmationPrompt = true;
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -g status-position top
      setw -g monitor-activity on
      set -g visual-activity on
      set -g detach-on-destroy off
      set -g renumber-windows on
      set -g @t-fzf-prompt '  '
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'fabioluciano/tmux-tokyo-night'
      set -g @plugin 'fcsonline/tmux-thumbs'
      set -gq allow-passthrough on

      unbind [
      bind Escape copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind P paste-buffer
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      bind r source-file ~/.tmux.conf \; display "Reloaded!"

      set-option -g status-right ""

      bind-key "t" run-shell "sesh connect \"$(
        sesh list | fzf-tmux -p 55%,60% \
          --no-sort --reverse --ansi --border-label ' sesh ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)'
      )\""

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
