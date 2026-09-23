{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      blender
      gimp3
      inkscape
      krita
      libreoffice

      hunspellDicts.en-au-large
    ];
  };
}
