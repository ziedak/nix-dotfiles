{ inputs, pkgs, lib, config, ... }:

with lib; 
let 
cfg = config.modules.hyprland;

mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };

in {
   imports = [
    hyprland.nixosModules.default
  ];
	
    home.packages = with pkgs; [
        # python39Packages.requests #?? if needed
        pamixer #  control the volume levels
	      brightnessctl # control device brightness
        swaybg # cycle wallpapers
        wlsunset # Day/night gamma adjustments
        wl-clipboard  # Wayland clipboard utilities, wl-copy and wl-paste
       
	];

        # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
   # wayland.windowManager.hyprland = {
   programs.hyprland={
    enable = true; 
    # package = inputs.hyprland.packages.${pkgs.system}.default.override {
    #   nvidiaPatches = true;
    # };
    systemdIntegration = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
    
 
services.wlsunset = {
    enable = true;
    latitude = "52.0";
    longitude = "21.0";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };

 systemd.user.services = {
    swaybg = mkService {
      Unit.Description = "Wallpaper chooser";
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${./wall.png}";
        Restart = "always";
      };
    };
  };
}
