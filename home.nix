{ lib, pkgs, ... }:
{
  imports = [
    ./modules/desktop
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "connor";
    homeDirectory = "/home/connor";
    stateVersion = "25.05";

    packages = with pkgs; [
      brave
      zed-editor
      keepassxc
      webcord

      oculante
      libqalculate
      satty

      brightnessctl
      playerctl
      grim
      slurp
      wl-clipboard-rs
    ];

    pointerCursor = {
      hyprcursor.enable = true;
      name = "rose-pine-hyprcursor";
      package = pkgs.rose-pine-hyprcursor;
    };
  };

  programs = {
    home-manager.enable = true;
    fish.enable = true;
    git = {
      enable = true;
      userName = "Connor Davis";
      userEmail = "concurac@proton.me";
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "hub" = {
          user = "connor";
          identityFile = "~/.ssh/home";
        };
        "github.com" = {
          user = "git";
          identityFile = "~/.ssh/git";
        };
      };
    };
    foot = {
      enable = true;
      server.enable = true;
    };
    bemenu.enable = true;
    mpv.enable = true;
    zathura.enable = true;
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;

    clipse.enable = true;
    mako.enable = true;

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
    userDirs.enable = true;
    terminal-exec.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];

        "image/gif" = [
          "oculante.desktop"
        ];
        "image/jpeg" = [
          "oculante.desktop"
        ];
        "image/png" = [
          "oculante.desktop"
        ];
        "image/webp" = [
          "oculante.desktop"
        ];
      };
    };
  };

  stylix = {
    enable = true;
    autoEnable = true;
    image = ./wallpaper.png;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono NF Extd";
      };
    };
    opacity = {
      terminal = 0.8;
    };
  };

  desktop = {
    enable = true;
    withUWSM = true;

    startup = [
      [
        "foot"
        "-s"
      ]
    ];

    binds =
      let
        terminal = "foot";
      in
      [
        {
          description = "Open foot terminal";
          command = [ "footclient" ];
          bind = "T";
          modifiers = [ "super" ];
        }
        {
          description = "Run applications with bemenu";
          command = [
            terminal
            "-e"
            (lib.getExe pkgs.j4-dmenu-desktop)
            "--dmenu='BEMENU_BACKEND=curses bemenu-run --auto-select --fork'"
          ];
          modifiers = [ "super" ];
          bind = "D";
          float = true;
        }
        {
          description = "Launch file explorer yazi";
          command = [
            terminal
            "-e"
            "yazi"
          ];
          modifiers = [ "super" ];
          bind = "E";
          float = true;
        }
        {
          description = "View clipboard history with clipse";
          command = [
            terminal
            "-e"
            "clipse"
          ];
          modifiers = [ "super" ];
          bind = "B";
          float = true;
        }
        {
          description = "Annotate screenshots with satty";
          command = ''grim -g "$(slurp)" - | satty -f - --fullscreen'';
          modifiers = [ "super" ];
          bind = "Print";
        }
        {
          command = [
            terminal
            "-e"
            "qalc"
            "-s"
            "autocalc"
          ];
          bind = "XF86Calculator";
          float = true;
        }
        {
          command = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "1%+"
          ];
          bind = "XF86AudioRaiseVolume";
          locked = true;
        }
        {
          command = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "1%-"
          ];
          bind = "XF86AudioLowerVolume";
          repeat = true;
          locked = true;
        }
        {
          command = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          bind = "XF86AudioMute";
          locked = true;
        }
        {
          command = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          bind = "XF86AudioMicMute";
          locked = true;
        }
        {
          command = [
            "brightnessctl"
            "s"
            "1%+"
          ];
          bind = "XF86MonBrightnessUp";
          repeat = true;
          locked = true;
        }
        {
          command = [
            "brightnessctl"
            "s"
            "1%-"
          ];
          bind = "XF86MonBrightnessDown";
          repeat = true;
          locked = true;
        }
        {
          command = [
            "playerctl"
            "next"
          ];
          bind = "XF86AudioNext";
          locked = true;
        }
        {
          command = [
            "playerctl"
            "play-pause"
          ];
          bind = "XF86AudioPause";
          locked = true;
        }
        {
          command = [
            "playerctl"
            "play-pause"
          ];
          bind = "XF86AudioPlay";
          repeat = true;
          locked = true;
        }
        {
          command = [
            "playerctl"
            "previous"
          ];
          bind = "XF86AudioPrev";
          repeat = true;
          locked = true;
        }
      ];
  };
}
