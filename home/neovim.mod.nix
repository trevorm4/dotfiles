_: {
  flake.hjemModules.neovim = { pkgs, ... }: {
    packages = with pkgs; [
      fzf
      lua5_1
      luarocks
      neovim
    ];

    environment.sessionVariables = {
      EDITOR = "nvim";
      LUA_CPATH = "$HOME/.luarocks/lib/lua/5.1/?.so;;";
      LUA_PATH = "$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua;;";
    };
  };
}
