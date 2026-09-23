{
  config,
  pkgs,
  ...
}:
{
  home = {
    sessionVariables = {
      WINEPREFIX = "${config.home.homeDirectory}/.prefix/music";
    };
    packages = with pkgs; [
      reaper
      yabridgectl
      yabridge
      vital
      aether-lv2
      dragonfly-reverb
      sfizz
    ];
  };
}
