{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      JULIA_HOME = "~/.local/share/julia";
    };
    packages = with pkgs; [
      freecad-wayland
      kicad
      julia-bin

      orca-slicer
    ];
  };
}
