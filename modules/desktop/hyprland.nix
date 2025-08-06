{ pkgs, ... }:
let
  mod = "SUPER";
  workspaceBinds = (
    # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
    builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      )
      9)
  ) ++ [
    # Switch to special workspace (scratchpad)
    "$mod, S, togglespecialworkspace, magic"
    "$mod SHIFT, S, movetoworkspace, special:magic"

    # Scroll through existing workspaces
    # with mod + scroll
    "$mod, mouse_down, workspace, m+1"
    "$mod, mouse_up, workspace, m-1"

    # Move active window through existing workspaces
    # with mod + shift + scroll
    "$mod SHIFT, mouse_down, movetoworkspace, m+1"
    "$mod SHIFT, mouse_up, movetoworkspace, m-1"

    # Scroll through existing workspaces
    # with mod + arrow keys
    "$mod, right, workspace, r+1"
    "$mod, left, workspace, r-1"

    # Move active window through existing workspaces
    # with mod + shift + arrow keys
    "$mod SHIFT, right, movetoworkspace, r+1"
    "$mod SHIFT, left, movetoworkspace, r-1"

    # Go to next empty workspace
    "$mod, ESCAPE, empty,"
  ];
  brightnessBinds = [
    ", XF86MonBrightnessUp, exec, brightnessctl s 1%+"
    ", XF86MonBrightnessDown, exec, brightnessctl s 1%-"
  ];
  audioBinds = [
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
  ];
  playerBinds = [
   ", XF86AudioPlay, exec, playerctl play-pause"
   ", XF86AudioPause, exec, playerctl play-pause"
   ", XF86AudioNext, exec, playerctl next"
   ", XF86AudioPrev, exec, playerctl previous"
  ];
in {
  wayland.windowManager.hyprland = {
    enable = true;
    # conflicts with uwsm
    systemd.enable = false;
    settings = {
      monitor = ",preferred,auto,1";

      # Set programs that you use
      "$terminal" = "footclient";
      "$popup" = "[float; size 40% 50%] $terminal -e";

      # CLI
      "$screenshot" = ''grim -g "$(slurp)" - | wl-copy'';
      "$annotate" = ''grim -g "$(slurp)" - | satty -f - --fullscreen'';

      # TUI
      "$files" = "$popup yazi";
      "$wifi" = "$popup impala";
      "$bluetooth" = "$popup bluetui";
      "$clipboard" = "$popup clipse";
      "$calculator" = "$popup qalc -s autocalc";

      # GUI
      "$menu" = "anyrun";

      "$run" = "uwsm-app --";

      exec-once = [
        "foot -s"
        "$run waypaper --restore"
      ];

      env = {
        HYPRCURSOR_SIZE = 32;
        HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      };

      input = {
        touchpad = {
          natural_scroll = true;
        };
      };

      "$mod" = mod;

      bind = workspaceBinds ++ [
        "$mod, Q, exec, $run $terminal"

        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
        "$mod, F, fullscreen,"

        "$mod, R, exec, $run $menu"
        "$mod, E, exec, $run $files"
        "$mod, H, exec, $run $clipboard"

        "$mod, W, exec, $run $wifi"
        "$mod, B, exec, $run $bluetooth"

        "$mod, O, exec, hyprpicker"

        "$mod, Print, exec, $run $annotate"
        ", Print, exec, $run $screenshot"
        ", XF86Calculator, exec, $run $calculator"
      ];

      bindl = playerBinds;
      bindel = brightnessBinds ++ audioBinds;

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "idleinhibit focus, fullscreen:1"
      ];
    };
  };

  programs = {
    hyprlock.enable = true;

    foot = {
      enable = true;
      server.enable = true;
    };
    anyrun = {
      enable = true;
      config = {
        closeOnClick = true;
        plugins = [
          "applications"
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
