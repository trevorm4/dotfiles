{ pkgs, ... }: {
  home.packages = with pkgs; [
    git
    gh
    jujutsu
    jjui
  ];
}
