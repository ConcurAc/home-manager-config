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
    rust.enable = true;
    go.enable = true;
    arduino.enable = true;
  };

  programs.sftpman = {
    enable = true;
    defaultSshKey = "~/.ssh/id_ed25519";
    mounts.games = {
      host = "opus.home.arpa";
      user = "connor";
      mountPoint = "/srv/users/connor";
      mountDestPath = "/srv/users/connor";
    };
  };

  home.packages = with pkgs; [
    sshfs
  ];
}
