{ config, lib, pkgs, ... }:

let
  cfg = config.features.gaming;
in
{
  imports = [
    ./clients.nix
    ./modding.nix
  ];

  options.features.gaming = {
    enable = lib.mkEnableOption "gaming";

    retroarch = {
      enable = lib.mkEnableOption "RetroArch";

      cores = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Extra cores, by pkgs.libretro attribute name";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        gamescope
        gamemode
        mangohud
        vulkan-tools
        umu-launcher
      ];
    })

    (lib.mkIf (cfg.enable && cfg.retroarch.enable) {
      programs.retroarch = {
        enable = true;
        cores = lib.genAttrs cfg.retroarch.cores (core: {
          enable = true;
          package = pkgs.libretro.${core};
        });
      };
    })
  ];
}
