{ modules, pkgs, ... }:
{
  imports = with modules.features; [
    ai
    gaming
  ];

  features.gaming = {
    enable = true;

    clients = {
      lutris.enable = true;
      heroic.enable = true;
      retroarch.enable = true;

      mgba.enable = true;
      dolphin.enable = true;
      melonds.enable = true;
      azahar.enable = true;
      ppsspp.enable = true;
      cemu.enable = true;
      eden.enable = true;
      shadps4.enable = true;

      prismlauncher.enable = true;

      daggerfall.enable = true;
      openmw.enable = true;

      ttt2.enable = true;
    };

    tools = {
      amethyst-mod-manager = {
        enable = true;
        package = pkgs.amethyst-mod-manager-unfree;
      };
      wii-u-downloader.enable = true;
    };
  };
}
