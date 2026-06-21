{ ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      keybind = [
        "ctrl+shift+left=new_split:left"
        "ctrl+shift+right=new_split:right"
        "ctrl+shift+up=new_split:up"
        "ctrl+shift+down=new_split:down"
        "alt+left=goto_split:left"
        "alt+right=goto_split:right"
        "alt+up=goto_split:up"
        "alt+down=goto_split:down"
        "alt+w=close_surface"
      ];
      "window-save-state" = "always";
    };
  };
}
