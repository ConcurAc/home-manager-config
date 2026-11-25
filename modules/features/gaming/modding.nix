{ config, lib, pkgs, ... }:

let
  cfg = config.features.gaming;
in
{
  options.features.gaming.modding.enable = lib.mkEnableOption "game modding tools";

  config = lib.mkIf (cfg.enable && cfg.modding.enable) {
    home.packages = [ pkgs.amethyst-mod-manager ];
  };
}
