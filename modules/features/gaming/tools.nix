{ config, lib, pkgs, ... }:

let
  cfg = config.features.gaming;
in
{
  options.features.gaming.tools.wii-u-downloader.enable = lib.mkEnableOption "WiiUDownloader";

  config = lib.mkIf (cfg.enable && cfg.tools.wii-u-downloader.enable) {
    home.packages = [ (pkgs.callPackage ./pkgs/wiiudownloader.nix { }) ];
  };
}
