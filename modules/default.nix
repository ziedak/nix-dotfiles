{ inputs,
  pkgs,
  config,
  lib,
  self,
  ... }:

{
    imports = [
        # gui
        ./gui/bottom
        ./gui/dunst
        ./gui/eww
        ./gui/firefox
        ./gui/hyprland
        ./gui/newsboat
        ./gui/rofi
        ./gui/snapshot
       # ./gui/swaylock
        ./gui/zathura

        # cli
        ./cli/bat
        ./cli/direnv
        ./cli/foot
        ./cli/git
        ./cli/gpg
        ./cli/nvim
        ./cli/tealdeer
        ./cli/wofi
        ./cli/zsh

        # system
        ./system/gtk
        ./system/packages
        inputs.hyprland.homeManagerModules.default
    ];


   
}
