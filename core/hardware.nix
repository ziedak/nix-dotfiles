
{ config, pkgs, inputs, ... }:

{

  services = { 
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

    
  };

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
