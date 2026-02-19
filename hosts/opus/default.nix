{
  lib,
  pkgs,
  ...
}:
{
  specialisation = {
    gaming = {
      configuration = {
        home = {
          packages = with pkgs; [
            prismlauncher
            daggerfall-unity
            openmw

            dolphin-emu
            melonds
            cemu
            ppsspp-sdl-wayland
            azahar

            shadps4
          ];
        };
        programs = {
          lutris = {
            enable = true;
            package = pkgs.lutris;
            extraPackages = with pkgs; [
              gamemode
              mangohud
              winetricks
              gamescope
              umu-launcher
              shadps4
            ];
            steamPackage = pkgs.steam;
            protonPackages = [
              pkgs.proton-ge-bin
            ];
            winePackages = [
              pkgs.wineWow64Packages.waylandFull
            ];
            runners = {
              web.package = pkgs.electron-bin;
              dolphin.package = pkgs.dolphin-emu;
              melonds.package = pkgs.melonds;
              cemu.package = pkgs.cemu;
              ppsspp.package = pkgs.ppsspp-sdl-wayland;
              citra.settings.runner.runner_executable = lib.getExe pkgs.azahar;

            };
          };
          retrom = {
            enable = true;
            supportNvidia = true;
          };
        };
      };
    };
  };
}
