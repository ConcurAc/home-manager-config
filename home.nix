{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "connor";
    homeDirectory = "/home/connor";
    stateVersion = "25.05";

    sessionVariables = {
      BROWSER = "brave";
      TERMCMD = "footclient";
    };

    shell = {
      enableNushellIntegration = true;
      enableFishIntegration = true;
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };

    packages = with pkgs; [
      brave
      zed-editor
      keepassxc
      webcord

      freecad-wayland
      blender
      gimp3
      inkscape
      krita

      oculante
      libqalculate
      satty
      file-roller

      brightnessctl
      playerctl

      wl-clipboard-rs

      impala
      bluetui

      prismlauncher
    ];
  };

  programs = {
    retrom.enable = true;
    home-manager.enable = true;
    fish.enable = true;
    git = {
      enable = true;
      settings.user = {
        name = "Connor Davis";
        email = "concurac@proton.me";
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "github.com" = {
          user = "git";
          identityFile = "~/.ssh/git";
        };
      };
    };
    bash.enable = true;
    nushell = {
      enable = true;
      settings = {
        show_banner = false;
      };
      extraConfig = ''
        def --env y [...args] {
          let tmp = (mktemp -t "yazi-cwd.XXXXXX")
          yazi ...$args --cwd-file $tmp
          let cwd = (open $tmp)
          if $cwd != "" and $cwd != $env.PWD {
            cd $cwd
          }
          rm -fp $tmp
        }
      '';
    };

    foot = {
      enable = true;
      server.enable = true;
    };
    eza.enable = true;
    broot.enable = true;
    atuin.enable = true;
    intelli-shell.enable = true;
    mise = {
      enable = true;
      settings = {
        all_compile = false;
      };
    };
    nix-your-shell.enable = true;
    bemenu.enable = true;
    mpv.enable = true;
    zathura.enable = true;

    lutris = {
      enable = true;
      package = pkgs.lutris;
      extraPackages = with pkgs; [
        gamemode
        mangohud
        winetricks
        gamescope
        umu-launcher
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

    niri = {
      enable = true;
      package = pkgs.niri;
      config = builtins.readFile ./dotfiles/niri/config.kdl;
    };
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;

    walker = {
      enable = true;
      settings = {
        force_keyboard_focus = true;
      };
      systemd.enable = true;
    };
    cliphist.enable = true;
    mako.enable = true;
    swww.enable = true;

    gammastep = {
      enable = true;
      dawnTime = "6:00-7:45";
      duskTime = "18:35-20:15";
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [
      "ZedMono NF Extd"
    ];
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
    terminal-exec.enable = true;
    portal = {
      enable = true;
      config = {
        common = {
          "org.freedesktop.impl.portal.FileChooser" = [
            "termfilechooser"
          ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-termfilechooser
      ];
    };
    mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        zathura
        oculante
        mpv
      ];
    };
  };

  stylix = {
    enable = true;
    base16Scheme = ./hephae-soft.yaml;
    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono NF Extd";
      };
    };
    icons = {
      package = pkgs.dracula-icon-theme;
    };
    polarity = "dark";
    opacity = {
      terminal = 0.8;
    };
  };
}
