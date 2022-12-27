{ pkgs, lib, config, inputs, ... }:

with lib;
let  browser = ["firefox.desktop"];

    associations = {
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/xhtml+xml" = browser;
        "application/x-extension-xhtml" = browser;
        "application/x-extension-xht" = browser;

        "audio/*" = ["mpv.desktop"];
        "video/*" = ["mpv.dekstop"];
        "image/*" = ["imv.desktop"];
        "application/json" = browser;
        "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
        "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
        "x-scheme-handler/spotify" = ["spotify.desktop"];
        "x-scheme-handler/discord" = ["WebCord.desktop"];
  }; 
in {
    imports = [./fonts.nix ./services.nix];
    nixpkgs.overlays = with inputs; [nixpkgs-wayland.overlay];

    environment = {
        etc."greetd/environments".text = ''
            Hyprland
        '';
        variables = {
            NIXOS_OZONE_WL = "1";
            __GL_GSYNC_ALLOWED = "0";
            __GL_VRR_ALLOWED = "0";
            _JAVA_AWT_WM_NONEREPARENTING = "1";
            DISABLE_QT5_COMPAT = "0";
            GDK_BACKEND = "wayland";
            ANKI_WAYLAND = "1";
            DIRENV_LOG_FORMAT = "";
            WLR_DRM_NO_ATOMIC = "1";
            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_QPA_PLATFORM = "wayland";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            QT_STYLE_OVERRIDE = "kvantum";
            MOZ_ENABLE_WAYLAND = "1";
            WLR_BACKEND = "vulkan";
            WLR_NO_HARDWARE_CURSORS = "1";
            XDG_SESSION_TYPE = "wayland";
            XDG_CURRENT_DESKTOP="Hyprland";
      
      XDG_SESSION_DESKTOP="Hyprland";
            SDL_VIDEODRIVER = "wayland";
            CLUTTER_BACKEND = "wayland";
            GTK_THEME = "Catppuccin-Frappe-Pink";
          #  WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
        };
        loginShellInit = ''
         dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        '';
        # loginShellInit = ''
        # dbus-update-activation-environment --systemd DISPLAY
        # eval $(gnome-keyring-daemon --start --components=ssh)
        # eval $(ssh-agent)
        # '';
    };

    xdg= {
        portal = {
            enable = true;
            wlr.enable = false;
            extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            inputs.xdg-portal-hyprland.packages.${pkgs.system}.default
            ];
        };


        mime = {
          enable = true;
          #associations.added = associations;
          defaultApplications = associations;
        };
  };
}

