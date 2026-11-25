{ config, lib, pkgs, ... }:

let
  cfg = config.features.gaming;

  clients = {
    mgba = {
      package = pkgs.mgba;
      core = "mgba";
    };
    dolphin = {
      package = pkgs.dolphin-emu;
      core = "dolphin";
    };
    melonds = {
      package = pkgs.melonds;
      core = "melondsds";
    };
    azahar = {
      package = pkgs.azahar;
      core = "citra";
    };
    ppsspp = {
      package = pkgs.ppsspp-sdl-wayland;
      core = "ppsspp";
    };
    cemu.package = pkgs.cemu;
    eden.package = pkgs.eden;
    shadps4.package = pkgs.shadps4;
    heroic.package = pkgs.heroic;
    prismlauncher.package = pkgs.prismlauncher;
    daggerfall.package = pkgs.daggerfall-unity;
    openmw.package = pkgs.openmw;
    ttt2.package = pkgs.callPackage ./pkgs/ttt2.nix { };
  };

  enabled = lib.filterAttrs (name: _: cfg.clients.${name}.enable) clients;

  cores = lib.concatMap (
    name:
    lib.optionals (clients.${name} ? core && cfg.clients.${name}.useCore) [ clients.${name}.core ]
  ) (builtins.attrNames enabled);
in
{
  options.features.gaming.clients = lib.mapAttrs (
    name: client:
    { enable = lib.mkEnableOption name; }
    // lib.optionalAttrs (client ? core) {
      useCore = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Add the ${client.core} RetroArch core";
      };
    }
  ) clients;

  config = lib.mkIf cfg.enable {
    home.packages = map (client: client.package) (builtins.attrValues enabled);

    programs.retroarch.cores = lib.mkIf cfg.retroarch.enable (
      lib.genAttrs (lib.unique cores) (core: {
        enable = true;
        package = pkgs.libretro.${core};
      })
    );
  };
}
