{ config, lib, inputs, ...}:

{
     config.home.stateVersion = "22.11";
     config.home.extraOutputsToInstall = ["doc" "devdoc"];
   
    imports = [../../modules/default.nix ];
    config.modules = {
        # gui
        bottom.enable = false;
        dunst.enable = false;
        eww.enable = false;
        firefox.enable = false;
        hyprland.enable = true;
        newsboat.enable = false;
        rofi.enable = false;
        snapshot.enable = false;
      #  swaylock.enable = false;
        zathura.enable = false;

        # cli
        bat.enable = false;
        direnv.enable = false;
        foot.enable = false;
        git.enable = false;
        gpg.enable = false;
        nvim.enable = false;
        tealdeer.enable = false;
        wofi.enable = false;
        zsh.enable = true;

        # system
        gtk.enable = true;
        packages.enable = false;

      };
  
}
