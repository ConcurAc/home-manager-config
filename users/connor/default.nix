{ config, pkgs, ... }:

{
  home = {
    username = "connor";
    homeDirectory = "/home/connor";
    stateVersion = "25.05";

    packages = with pkgs; [
      brave
      zed-editor
      keepassxc
      webcord

      blender
      gimp3
      inkscape
      libreoffice-fresh
      freecad
    ];
  };

  programs = {
    home-manager.enable = true;
    bash.initExtra = ''
      [[ -f ~/.cache/wallust/sequences ]] && cat ~/.cache/wallust/sequences
    '';
    fish = {
      enable = true;
      interactiveShellInit = ''
        test -e ~/.cache/wallust/sequences && cat ~/.cache/wallust/sequences
      '';
    };
    git = {
      enable = true;
      userName = "Connor Davis";
      userEmail = "concurac@proton.me";
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          user = "git";
          identityFile = "~/.ssh/git";
        };
      };
    };
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;
  };

  xdg = {
    userDirs.enable = true;
    terminal-exec.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
