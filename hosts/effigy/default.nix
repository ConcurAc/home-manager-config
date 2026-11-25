{ modules, pkgs, ... }:
{
  imports = with modules.features; [
    ai
    gaming
    productivity
    music
    development
    engineering
    security
  ];

  features.gaming = {
    enable = true;

    clients = {
      retroarch = {
        enable = true;
        cores = [
          "gpsp"
          "mupen64plus"
        ];
      };

      lutris.enable = true;

      mgba.enable = true;
      dolphin.enable = true;
      melonds.enable = true;
      azahar.enable = true;
      ppsspp.enable = true;
      cemu.enable = true;
      eden.enable = true;
      shadps4.enable = true;

      heroic.enable = true;
      prismlauncher.enable = true;
      daggerfall.enable = true;
      openmw.enable = true;
      ttt2.enable = true;
    };

    modding.enable = true;

    tools.wii-u-downloader.enable = true;
  };

  features.development = {
    rust = {
      enable = true;
      cargoHome = "$HOME/.local/share/cargo";
      rustupHome = "$HOME/.local/share/rustup";
    };
    go = {
      enable = true;
      goPath = "$HOME/.local/share/go";
      goModCache = "$HOME/.cache/go/pkg/mod";
    };
    arduino = {
      enable = true;
      arduinoData = "$HOME/.local/share/arduino";
    };
    esp = {
      enable = true;
      exportFile = "$HOME/.cache/export-esp.sh";
    };
  };

  programs.sftpman = {
    enable = true;
    defaultSshKey = "~/.ssh/id_ed25519";
    mounts = {
      media = {
        host = "opus.home.arpa";
        user = "connor";
        mountPoint = "/srv/media";
        mountDestPath = "/srv/media";
        mountOptions = [ "follow_symlinks" ];
      };
      user = {
        host = "opus.home.arpa";
        user = "connor";
        mountPoint = "/srv/users/connor";
        mountDestPath = "/srv/users/connor";
        mountOptions = [ "follow_symlinks" ];
      };
    };
  };

  home.packages = with pkgs; [
    sshfs
  ];
}
