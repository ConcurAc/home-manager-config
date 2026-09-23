{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gamescope
      heroic
      prismlauncher
      daggerfall-unity
      openmw
      ukmm

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
          package = melondsds;
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
        vulkan-tools
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
        citra.package = pkgs.azahar;
        yuzu.package = pkgs.eden;
        shadps4.package = pkgs.shadps4;
      };
    };
    retrom.enable = true;
  };
}
