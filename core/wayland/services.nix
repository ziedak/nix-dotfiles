{
  config,
  pkgs,
  ...
}: {
  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  services = {

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "zied";
        };
        default_session = initial_session;
      };
    };


    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
  
  
    printing.enable = false;
    lorri.enable = true;
    udisks2.enable = true;
    fstrim.enable = true;
    
    pipewire = {
      enable = true;
      alsa = {
          enable = true;
          support32Bit = true;
        };
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # other
      # wireplumber.enable = true;
    };

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    
  

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };

  };
}
