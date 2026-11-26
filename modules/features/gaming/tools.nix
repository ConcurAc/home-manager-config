{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.features.gaming;
in
{
  options.features.gaming.tools = {
    wii-u-downloader = {
      enable = lib.mkEnableOption "WiiUDownloader";
      package = lib.mkPackageOption {
        wii-u-downloader = pkgs.callPackage ./pkgs/wiiudownloader.nix { };
      } "wii-u-downloader" { };
    };
    amethyst-mod-manager = {
      enable = lib.mkEnableOption "amethyst mod manager";
      package = lib.mkPackageOption pkgs "amethyst-mod-manager" { };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.enable && cfg.tools.wii-u-downloader.enable) {
      home.packages = [ cfg.tools.wii-u-downloader.package ];
    })
    (lib.mkIf (cfg.enable && cfg.tools.amethyst-mod-manager.enable) {
      home.packages = [ cfg.tools.amethyst-mod-manager.package ];
    })
  ];
}
