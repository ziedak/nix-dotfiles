{
  config,
  pkgs,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      # material-icons
      # material-design-icons
      # work-sans
      # comic-neue
      # source-sans
      # twemoji-color-font
      # comfortaa
      # inter
      # lato
      # lexend
      # dejavu_fonts
      # noto-fonts
      # noto-fonts-cjk
      # noto-fonts-emoji

      jetbrains-mono
      roboto
      openmoji-color
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

  
# Install fonts
    

        fontconfig = {
            hinting.autohint = true;
            defaultFonts = {
              # monospace = [
              #   "Iosevka Term"
              #   "Iosevka Term Nerd Font Complete Mono"
              #   "Iosevka Nerd Font"
              #   "Noto Color Emoji"
              # ];
              # sansSerif = ["Lexend" "Noto Color Emoji"];
              # serif = ["Noto Serif" "Noto Color Emoji"];
              emoji = [ "OpenMoji Color" ];
            };
        };
    };

  
}

