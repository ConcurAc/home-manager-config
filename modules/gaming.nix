{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ctrtool # 3ds extraction
  ];

  programs.lutris = {
    enable = true;
    package = pkgs.lutris-free;
    extraPackages = with pkgs; [
      # Games
      prismlauncher # Minecraft

      # Extra Dependencies
      libadwaita gtk4 git p7zip libwebp
    ];
    protonPackages = with pkgs; [
      proton-ge-bin
    ];
    winePackages = with pkgs; [
      wineWowPackages.waylandFull
    ];
    runners = {
      melonds.package = pkgs.melonDS;
      dolphin.package = pkgs.dolphin-emu;
      cemu.package = pkgs.cemu;

      citra.settings.runner.runner_executable = "${pkgs.azahar}/bin/azahar";
    };
  };
}
