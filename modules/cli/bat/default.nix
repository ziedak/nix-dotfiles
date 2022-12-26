{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.bat;

in {
  options.modules.bat = { enable = mkEnableOption "bat"; };
  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      themes = {
        Catppuccin-frappe = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "00bd462e8fab5f74490335dcf881ebe7784d23fa";
          sha256 = "yzn+1IXxQaKcCK7fBdjtVohns0kbN+gcqbWVE4Bx7G8=";
        } + "/Catppuccin-frappe.tmTheme");
      };
      config.theme = "Catppuccin-frappe";
    };
  };
}