{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./blocker.nix
    ./bootloader.nix 
    ./cron.nix
    ./environment
    ./hardware.nix
    ./i18n.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./security.nix
    ./system.nix
    ./users.nix
    ./virtualisation.nix
    ./wayland
 ];
}
