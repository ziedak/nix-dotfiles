{config, pkgs,...}:
{
    system={
        autoUpgrade.enable = false;
        # Do not touch
        system.stateVersion = "22.11";
    };
}