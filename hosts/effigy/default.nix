{ modules, pkgs, ... }:
{
  imports = with modules.features; [
    gaming
    productivity
    music
    development
    engineering
    security
  ];

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
