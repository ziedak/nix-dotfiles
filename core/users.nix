{
  config,
  pkgs,
  ...
}: {
  users.users.zied = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gitea"
      "docker"
      "systemd-journal"
      "audio"
      "plugdev"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
      "power"
      "nix"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe"];
  };

   # Enable automatic login for the user.
   services.xserver.displayManager={
    autoLogin.enable = true;
    autoLogin.user = "zied";
    };

}
