{ config, lib, pkgs, ... }:

let
  cfg = config.features.gaming;
in
{
  imports = [
    ./clients.nix
    ./modding.nix
    ./tools.nix
  ];

  options.features.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gamescope
      gamemode
      mangohud
      vulkan-tools
      umu-launcher
    ];
  };
}
