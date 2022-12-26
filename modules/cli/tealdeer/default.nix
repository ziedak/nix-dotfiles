{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.tealdeer;

in {
    options.modules.tealdeer = { enable = mkEnableOption "tealdeer"; };
    config = mkIf cfg.enable {
        programs.tealdeer = {
            enable = true;
            settings = {
                display = {
                compact = false;
                use_pager = true;
                };
                updates = {
                auto_update = true;
                };
            };
            };
        };
}
