{
  config,
  pkgs,
  ...
}:

{
    virtualisation={
        vmware.guest.enable = true;
        docker.enable = true;
        };
}
