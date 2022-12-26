{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; 
let
  cfg = config.modules.snapshot;
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
in {

  options.modules.snapshot= { enable = mkEnableOption "snapshot"; };
    config = mkIf cfg.enable {
	
  home.packages = with pkgs; [

    wf-recorder # screen recording of wlroots -based compositors
    slurp # select a region in a Wayland compositor and print it to the standard output
    tesseract5 # Preprocess Images for Text OCR
    swappy #snapshot and editor too
    ocr
    grim
    screenshot
    pngquant # PNG compressor
  ];

  };
 
}
