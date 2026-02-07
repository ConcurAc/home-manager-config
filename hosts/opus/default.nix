{
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
              pkgs.wineWowPackages.waylandFull
            ];
            runners = {
              web.package = pkgs.electron-bin;
              dolphin.package = pkgs.dolphin-emu;
              melonds.package = pkgs.melonDS;
              cemu.package = pkgs.cemu;
              citra.settings.runner.runner_executable = "${pkgs.azahar}/bin/azahar";
            };
          };
        };
      };
    };
  };
}
