{
  config,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "ssh/default.pub" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
      "ssh/default" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      "ssh/git.pub" = {
        path = "${config.home.homeDirectory}/.ssh/git.pub";
      };
      "ssh/git" = {
        path = "${config.home.homeDirectory}/.ssh/git";
      };
    };
  };

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
      thunderbird

      oculante
      libqalculate
      satty
      file-roller

      brightnessctl
      playerctl
      wl-clipboard-rs

      pw-viz
      impala
      bluetui
    ];

    file = {
      ".config/niri/config.kdl".source = ./dotfiles/niri/config.kdl;
    };
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      settings.user = {
        name = "Connor Davis";
        email = "connor@scequ.com";
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
    fish.enable = true;
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

    eza.enable = true;
    broot.enable = true;
    atuin.enable = true;
    intelli-shell.enable = true;
    mise.enable = true;
    nix-your-shell.enable = true;

    foot = {
      enable = true;
      server.enable = true;
    };
    vicinae = {
      enable = true;
      systemd.enable = true;
    };
    mpv.enable = true;
    zathura.enable = true;
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;

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
