{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}:
let
  secrets = config.sops.secrets;
  name = "connor";
in
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
      "crypt/archives" = { };
      "crypt/media" = { };
      "crypt/games" = { };
    };
  };

  home = {
    username = name;
    homeDirectory = "/home/${name}";
    stateVersion = "26.05";

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

  accounts = {
    email = {
      accounts = {
        connor = {
          address = "connor@scequ.com";
          userName = "connor@scequ.com";
          realName = "Connor Davis";
          passwordCommand = "pass email/connor@scequ.com";

          primary = true;

          gpg = {
            key = "BB2DDC4B16831A49D56DB6A5095D786B07813F06";
            signByDefault = true;
            encryptByDefault = true;
          };

          imap = {
            host = "mail.scequ.com";
            port = 993;
            tls.enable = true;
          };

          smtp = {
            host = "mail.scequ.com";
            port = 465;
            tls.enable = true;
          };

          meli = {
            enable = true;
            settings = {
              format = "imap";
              server_hostname = "mail.scequ.com";
              server_port = 993;
              server_username = "connor@scequ.com";
              server_password_command = "pass email/connor@scequ.com";
            };
          };
        };
      };
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
    zathura = {
      enable = true;
      extraConfig = ''
        set selection-clipboard clipboard
      '';
    };

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
        provider.llama-swap = {
          npm = "@ai-sdk/openai-compatible";
          name = "Local";
          options = {
            baseURL = "https://llama.home.arpa/v1";
          };
          models = {
            "gemma-4-e4b-uncensored" = {
              id = "gemma-4-e4b-uncensored";
              name = "Gemma 4 e4b Uncensored";
              tool_call = true;
            };
            options.baseURL = "https://llama.home.arpa/v1";
          };
        };
      };
    };

    zed-editor = {
      enable = true;
      enableMcpIntegration = true;
    };
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;

    mako.enable = true;
    awww.enable = true;

    gammastep = {
      enable = true;
      temperature = {
        day = 4000;
        night = 2500;
      };
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
    userDirs = {
      enable = true;
      setSessionVariables = true;
    };
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

  systemd.user = lib.mergeAttrsList (
    map
      (
        f:
        let
          module = "srv-users-${name}-${f}";
          gocryptfs = lib.getExe' pkgs.gocryptfs "gocryptfs";
        in
        {
          mounts.${module} = {
            Unit.Description = "${f} mount";

            Mount = {
              What = "${gocryptfs}#/srv/users/${name}/.crypt/@${f}";
              Where = "/srv/users/${name}/${f}";
              Type = "fuse";
              Options = "passfile=${secrets."crypt/${f}".path}";
            };

            Install.WantedBy = [ "default.target" ];
          };
          automounts.${module} = {
            Unit.Description = "${f} automount";

            Automount = {
              Where = "/srv/users/${name}/${f}";
            };

            Install.WantedBy = [ "default.target" ];
          };
        }
      )
      [
        "archives"
        "media"
        "games"
      ]
  );
}
