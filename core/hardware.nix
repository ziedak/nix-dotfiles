
{ config, pkgs, inputs, ... }:

{

  # Enable sound with pipewire.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
  hardware = {
    bluetooth.enable = false;
    
    pulseaudio={
      enable = false;
      # support32Bit = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  

}
