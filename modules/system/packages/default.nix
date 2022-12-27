{ pkgs, lib, config, ... }:

with lib;
let cfg = 
    config.modules.packages;
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';
    mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
        src = pkgs.fetchFromGitHub {
        owner = "mpv-player";
        repo = "mpv";
        rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
        sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
        };
     });

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    #nixpkgs.config.allowUnfree = false;
    config = mkIf cfg.enable {
    	home.packages = with pkgs; [

            # bandw
            #bandwhich # Bandwidth Tracking
           
            cached-nix-shell
          #  dconf # Gnome  editor of applications internal settings
            exa # better than ls
            fd # find entries in your filesystem
            # ffmpeg
            # figlet # making large letters out of ordinary text
            fzf # fuzzy finder
            # gcc # GNU Compiler Collection
            # gnupg # gpg/gnupg: The GNU Privacy Guard
            # grex # creating regular expression
            htop #  interactive process viewer
            # hyperfine # benchmarking tool.
            # imagemagick # displaying, converting, and editing raster image
            # jq # JSON processo
            # keepassxc # password manager
            # libnotify # Send desktop notifications.
            # libreoffice-fresh
            # lm_sensors # Hardware monitoring
            # lowdown # simple markdown translator
            # maintenance
            # mpv-unwrapped # media player
            # pass # simple password storage system
            # pavucontrol # audio control manager
            # pqiv #  powerful GTK 3 based command-line image viewer
            ripgrep # recursively searches the current directory for a regex pattern
            # rsync # remote synchronization 
            # todo
            # transmission-gtk # torrent client
            ttyper # terminal-based typing 
            # unzip
            xfce.thunar # file manager
            # xh # fast tool for sending HTTP requests
            # yt-dlp # youtube
            
            #wf-recorder # screen recording
            #python3
            #lua
            #zig
           
        ];
    };
}
