{
  config,
  pkgs,
  pkgs-stable,
  ...
}:
{
  home = {
    sessionVariables = {
      WINEPREFIX = "${config.home.homeDirectory}/.prefix/music";
    };
    packages = with pkgs; [
      reaper
      pkgs-stable.yabridgectl
      pkgs-stable.yabridge
      vital
      aether-lv2
      dragonfly-reverb
      sfizz
    ];
  };
}
