{ config, pkgs, ... }:

{
  home = {
    username = "connor";
    homeDirectory = "/home/connor";
    stateVersion = "25.05";

    file = {
      "${config.xdg.configHome}/hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
      "${config.xdg.configHome}/hypr/hyprland".source = ./dotfiles/hypr/hyprland;
      "${config.xdg.configHome}/wallust/wallust.toml".source = ./dotfiles/wallust/wallust.toml;
      "${config.xdg.configHome}/wallust/templates".source = ./dotfiles/wallust/templates;
    };
    packages = with pkgs; [
      brave
      zed-editor
      keepassxc
      webcord

      blender
      gimp3
      inkscape
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
    wallust.enable = true;
  };

  services = {
    syncthing.enable = true;
  };

  xdg = {
    userDirs.enable = true;
    terminal-exec.enable = true;
  };
}
