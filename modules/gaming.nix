{ pkgs, ... }:
with pkgs;
let
  # pkgs prefix for 64 and 86 bit software
  game_dependencies = pkgs: [
    # Runners
    wineWowPackages.waylandFull # Windows

    dolphin-emu # Wii
    cemu # Wii U

    melonDS # DS
    azahar # 3DS

    shadps4 # PS4

    # Games
    prismlauncher # Minecraft

    # Dependencies
    libadwaita gtk4 git p7zip libwebp # HSR
  ];
in {
  home.packages = [
    (lutris-free.override {
      extraLibraries = game_dependencies;
    })
    protonup # protonGE manager
    ctrtool # 3ds extraction
    cwiid # Wii controller
  ];
}
