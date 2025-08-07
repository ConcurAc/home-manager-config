{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    # conflicts with uwsm
    systemd.enable = false;
  };

  programs = {
    hyprlock.enable = true;

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          alpha = 0.8;
          font = "font=monospace:size=16";
          dpi-aware = "yes";
        };
      };
    };
    anyrun = {
      enable = true;
      config = {
        closeOnClick = true;
        plugins = with pkgs; [
          "libapplications.so"
        ];
      };
    };

    imv.enable = true;
    mpv.enable = true;
    zathura.enable = true;
  };

  services = {
    hypridle.enable = true;
    hyprpolkitagent.enable = true;
    hyprsunset.enable = true;
    swww.enable = true;
    clipse.enable = true;
  };

  home = {
    pointerCursor = {
      hyprcursor.enable = true;
      name = "rose-pine-hyprcursor";
      package = pkgs.rose-pine-hyprcursor;
    };
    packages = with pkgs; [
      # First party packages
      hyprpicker

      # Third party packages
      libayatana-appindicator-gtk3 # app indicators
      satty # annotation util

      # CLI
      brightnessctl # screen brightness
      playerctl # audio playback
      wireplumber # pipewire control
      wl-clipboard # clipboard
      grim # screenshot util
      slurp # screen selection util

      # TUI
      impala # wifi
      bluetui # bluetooth
      libqalculate # calculator

      # GUI
      anyrun # application runner
      waypaper # wallpaper setter
      file-roller # archive manager
    ];
  };

  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
}
