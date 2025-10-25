{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      reaper
#      infamousPlugins

      vital
      aether-lv2
      dragonfly-reverb
      mod-distortion
      quadrafuzz
      fire
      guitarix
      # carla
      sfizz

      yabridge
      yabridgectl
    ]
    ++ (with magnetophonDSP; [
      shelfMultiBand
      pluginUtils
      faustCompressors
      VoiceOfFaust
      RhythmDelay
      MBdistortion
      LazyLimiter
      CompBus
      CharacterCompressor
    ]);
}
