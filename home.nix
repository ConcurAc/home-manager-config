{
  config,
  lib,
  pkgs,
  pkgs-stable,
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
      enableFishIntegration = true;
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };

    packages = with pkgs; [
      brave
      zed-editor
      geary
      dino
      thunderbird

      pkgs-stable.oculante
      libqalculate
      satty
      file-roller

      brightnessctl
      playerctl

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

    helix.enable = true;

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
      settings = {
        font.normal.family = "system";
      };
    };

    mpv.enable = true;
    zathura.enable = true;
    halloy.enable = true;

    mcp = {
      enable = true;
      servers = {
        nixos.command = lib.getExe pkgs.mcp-nixos;
      };
    };

    opencode = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        provider = {
          "llama-swap" = {
            npm = "@ai-sdk/openai-compatible";
            models = {
              "Qwen3.5 Uncensored" = {
                name = "qwen3.5-9b-uncensored";
                tool_call = true;
                reasoning = true;
              };
              "Gemma 4 Uncensored" = {
                name = "gemma-4-e4b-uncensored";
                tool_call = true;
                reasoning = true;
              };
            };
            options.baseURL = "https://llama.home.arpa/v1";
          };
        };
      };
    };
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;

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
        yazi
        zathura
        pkgs-stable.oculante
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
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono NF Extd";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    icons = {
      enable = true;
      package = pkgs.dracula-icon-theme;
      dark = "Dracula";
    };
    polarity = "dark";
    opacity = {
      terminal = 0.8;
    };
  };
}
