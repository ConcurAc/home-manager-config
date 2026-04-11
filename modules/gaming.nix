{
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      prismlauncher
      daggerfall-unity
      openmw

      dolphin-emu
      melonds
      azahar
      cemu
      eden
      ppsspp-sdl-wayland
      shadps4
    ];
  };
  programs = {
    retroarch = {
      enable = true;
      cores = with pkgs.libretro; {
        "mGBA" = {
          enable = true;
          package = mgba;
        };
        "Mupen64 Plus" = {
          enable = true;
          package = mupen64plus;
        };
        "Dolphin" = {
          enable = true;
          package = dolphin;
        };
        "melonDS" = {
          enable = true;
          package = melonds;
        };
        "PPSSPP" = {
          enable = true;
          package = ppsspp;
        };
      };
    };
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
}
