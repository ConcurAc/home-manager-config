{ config, pkgs, ... }:
let
  appearance = ''
    # Refer to https://wiki.hyprland.org/Configuring/Variables/

    # https://wiki.hyprland.org/Configuring/Variables/#general
    general {
        gaps_in = 5
        gaps_out = 20

        border_size = 2

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false

        layout = dwindle
    }

    # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration {
        rounding = 10

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0
        inactive_opacity = 1.0

        shadow {
            enabled = false
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur {
            enabled = false
            size = 3
            passes = 1

            vibrancy = 0.1696
        }
    }

    # https://wiki.hyprland.org/Configuring/Variables/#animations
    animations {
        enabled = true

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1

        animation = global, 1, 10, default
        animation = border, 1, 5.39, easeOutQuint
        animation = windows, 1, 4.79, easeOutQuint
        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation = windowsOut, 1, 1.49, linear, popin 87%
        animation = fadeIn, 1, 1.73, almostLinear
        animation = fadeOut, 1, 1.46, almostLinear
        animation = fade, 1, 3.03, quick
        animation = layers, 1, 3.81, easeOutQuint
        animation = layersIn, 1, 4, easeOutQuint, fade
        animation = layersOut, 1, 1.5, linear, fade
        animation = fadeLayersIn, 1, 1.79, almostLinear
        animation = fadeLayersOut, 1, 1.39, almostLinear
        animation = workspaces, 1, 1.94, almostLinear, fade
        animation = workspacesIn, 1, 1.21, almostLinear, fade
        animation = workspacesOut, 1, 1.94, almostLinear, fade
    }

    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle {
        pseudotile = true # Master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
        preserve_split = true # You probably want this
    }

    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master {
        new_status = master
    }

    # https://wiki.hyprland.org/Configuring/Variables/#misc
    misc {
        vfr = true

        force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(

        font_family = monospace
    }
  '';
  input = ''
    # https://wiki.hyprland.org/Configuring/Variables/#input
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

        touchpad {
            natural_scroll = true
            tap-to-click = 0
        }
        tablet {
            output = current
            left_handed = true
        }
    }

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures {
        workspace_swipe = true
    }

    # Switch workspaces with mod + [0-9]
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10

    # Move active window to a workspace with mod + SHIFT + [0-9]
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9
    bind = SUPER SHIFT, 0, movetoworkspace, 10

    # Example special workspace (scratchpad)
    bind = SUPER, S, togglespecialworkspace, magic
    bind = SUPER SHIFT, S, movetoworkspace, special:magic

    # Scroll through existing workspaces
    # with mod + scroll
    bind = SUPER, mouse_down, workspace, e+1
    bind = SUPER, mouse_up, workspace, e-1

    # Move active window through existing workspaces
    # with mod + shift + scroll
    bind = SUPER SHIFT, mouse_down, movetoworkspace, e+1
    bind = SUPER SHIFT, mouse_up, movetoworkspace, e-1

    # Scroll through existing workspaces
    # with mod + arrow keys
    bind = SUPER, right, workspace, e+1
    bind = SUPER, left, workspace, e-1

    # Move active window through existing workspaces
    # with mod + shift + arrow keys
    bind = SUPER SHIFT, right, movetoworkspace, e+1
    bind = SUPER SHIFT, left, movetoworkspace, e-1

    # Move/resize windows with mod + LMB/RMB and dragging
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow

    # Laptop multimedia keys for volume and LCD brightness
    bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
    bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
    bindel = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = , XF86MonBrightnessUp, exec, brightnessctl s 1%+
    bindel = , XF86MonBrightnessDown, exec, brightnessctl s 1%-

    # Requires playerctl
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous
  '';
  rules = ''
    # Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
    workspace = w[tv1], gapsout:0, gapsin:0
    workspace = f[1], gapsout:0, gapsin:0
    windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
    windowrule = rounding 0, floating:0, onworkspace:w[tv1]
    windowrule = bordersize 0, floating:0, onworkspace:f[1]
    windowrule = rounding 0, floating:0, onworkspace:f[1]

    # Ignore maximize requests from apps. You'll probably like this.
    windowrule = suppressevent maximize, class:.*

    # Fix some dragging issues with XWayland
    windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    windowrule = idleinhibit focus, fullscreen:1
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    # conflicts with uwsm
    systemd.enable = false;
    extraConfig = ''
      # Refer to the wiki for more information.
      # https://wiki.hyprland.org/Configuring/

      source = ~/.config/hypr/colors.conf

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=, preferred, auto, 1

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use

      $run = uwsm-app --

      $terminal = footclient
      $popup = [float; size 50% 40%] $run $terminal -e

      # CLI
      $screenshot = grim -g "$(slurp)" - | wl-copy
      $annotate = grim -g "$(slurp)" - | satty -f - --fullscreen

      # TUI
      $files = yazi
      $wifi = impala
      $bluetooth = bluetui
      $clipboard = clipse
      $calculator = qalc -s autocalc

      # GUI
      $menu = anyrun

      exec-once = $run foot -s
      exec-once = $run waypaper --restore

      # BINDS

      $mod = SUPER
      bind = $mod, Q, exec, $run $terminal

      bind = $mod, C, killactive,
      bind = $mod, M, exit,
      bind = $mod, V, togglefloating,
      bind = $mod, P, pseudo,
      bind = $mod, J, togglesplit,

      bind = $mod, R, exec, $run $menu
      bind = $mod, E, exec, $popup $files
      bind = $mod, H, exec, $popup $clipboard

      bind = $mod, W, exec, $popup $wifi
      bind = $mod, B, exec, $popup $bluetooth

      bind = $mod, O, exec, hyprpicker

      bind = $mod, Print, exec, $run $annotate
      bind = , Print, exec, $run $screenshot
      bind = , XF86Calculator, exec, $popup $calculator

      ${appearance}
      ${input}
      ${rules}
    '';
  };

  programs = {
    hyprlock.enable = true;

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "monospace:size=14";
          dpi-aware = "yes";
        };
        colors = {
          alpha = "0.8";
        };
      };
    };
    anyrun = {
      enable = true;
      config = {
        x.fraction = 0.5;
        y.fraction = 0.5;
        width.absolute = 800;
        height.fraction = 0.75;

        plugins = [
          "libapplications.so"
        ];
      };
      extraCss = ''
        @import url("colors.css");

        @define-color window alpha(@color13, 0.2);

        @define-color bg alpha(@color0, 0.8);
        @define-color bg-selected alpha(@color6, 0.7);

        @define-color border @color14;

        @define-color text @color15;
        @define-color text-selected @color7;

        * {
            font-family: monospace;

            margin: 0;
            padding: 0;

            border-style: none;
            border-width: 2px;
            border-radius: 12px;
            border-color: @border;

            outline: none;

            background: none;

            color: @text;
        }

        window {
            color: @cursor;
            background-color: @window;
        }

        entry {
            padding: 0.1rem;
            border-style: solid;
            background-color: @bg;
        }

        #main {
            margin-top: 2px;
        }

        #main box {
            padding: 4px;

            border-style: solid;

            background-color: @bg;
        }

        #main box * {
            border-style: none;

            background: none;
        }

        #plugin {
            margin-top: 1px;
            margin-bottom: 1px;
            font-weight: bold;
            background: none;
        }

        #plugin * {
            margin: 0;
        }

        #match {
            margin: 2px;
            padding: 2px;

            color: @text;
        }

        #match:selected {
            padding: 0px;
            border-style: solid;

            color: @text-selected;

            background-color: @bg-selected;
        }

        #match * {
            margin: 0;
        }

        #match-title {
            font-weight: bold;
        }

        #match-desc {
            font-style: italic;
            font-weight: normal;
        }
      '';
    };

    imv.enable = true;
    mpv.enable = true;
    zathura.enable = true;
  };

  services = {
    hypridle.enable = true;
    hyprpolkitagent.enable = true;
    hyprsunset = {
      enable = true;
      settings = {
        max-gamma = 150;
        profile = [
          {
            time = "7:30";
            temperature = 4000;
            identity = true;
          }
          {
            time = "21:00";
            temperature = 3000;
            gamma = 0.8;
          }
        ];
      };
    };
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
