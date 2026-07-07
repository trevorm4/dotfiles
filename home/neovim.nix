{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    fzf
    lua5_1
    luarocks
  ];

  home.sessionVariables = {
    LUA_PATH = "$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;;";
    LUA_CPATH = "$HOME/.luarocks/lib/lua/5.1/?.so;;";
  };
}
