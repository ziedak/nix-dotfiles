{config, pkgs,...}:
{
    system={
        autoUpgrade.enable = false;
        # Do not touch
        stateVersion = "22.11";
    };
}