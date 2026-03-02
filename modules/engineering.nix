{ pkgs, pkgs-stable, ... }:
{
  home = {
    sessionVariables = {
      JULIA_HOME = "~/.local/share/julia";
    };
    packages = with pkgs; [
      pkgs-stable.freecad-wayland
      kicad
      julia-bin
    ];
  };
}
