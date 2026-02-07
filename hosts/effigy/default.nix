{
  config,
  pkgs,
  pkgs-stable,
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
    productivity.configuration = {
      home = {
        packages = with pkgs; [
          blender
          gimp3
          inkscape
          krita
        ];
      };
    };
    development.configuration = {
      home = {
        sessionVariables = {
          CARGO_HOME = "~/.local/share/cargo";
          RUSTUP_HOME = "~/.local/share/rustup";
        };
        packages = with pkgs; [
          rustup
        ];
      };
    };
    engineering.configuration = {
      home = {
        sessionVariables = {
          JULIA_HOME = "~/.local/share/julia";
        };
        packages = with pkgs; [
          pkgs-stable.freecad-wayland
          julia-bin
        ];
      };
    };
    music.configuration = {
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
    };
  };
}
