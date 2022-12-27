{inputs,
  config,
  pkgs,
  ...
}: {




  environment = {
    # set channels (backwards compatibility)
    etc = {
      "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
      "nix/flake-channels/home-manager".source = inputs.home-manager;
    };

    variables = {
      ANKI_WAYLAND = "1";
      BROWSER = "firefox";
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
      EDITOR = "nvim";
      GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
      GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      XDG_DATA_HOME = "$HOME/.local/share";
      ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
    };

  systemPackages = with pkgs; [
    git
    (writeScriptBin "sudo" ''exec doas "$@"'')
  ];

  defaultPackages = [];
  };
}
