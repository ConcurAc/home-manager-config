{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop;

  modifierMap = {
    super = "SUPER";
    shift = "SHIFT";
    alt = "ALT";
    ctrl = "CTRL";
  };

  run = if cfg.withUWSM then "uwsm-app --" else "";

  layout = ''
    monitor = , preferred, auto, 1

    general {
      gaps_in = 5
      gaps_out = 20
      border_size = 2
      layout = dwindle
    }

    dwindle {
      pseudotile = true
    }
  '';
  input = ''
    input {
      touchpad {
        tap-to-click = false
        natural_scroll = true
      }

      tablet {
        left_handed = true
      }
    }

    gesture = 3, horizontal, workspace

  '';
  appearance = ''
    decoration {
      rounding = 10
      active_opacity = 1.0
      inactive_opacity = 1.0
    }

    animations {
      enabled = true

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
  '';
  binds = ''
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

    bind = SUPER, S, togglespecialworkspace, magic
    bind = SUPER SHIFT, S, movetoworkspace, special:magic

    bind = SUPER, mouse_down, workspace, e+1
    bind = SUPER, mouse_up, workspace, e-1
    bind = SUPER SHIFT, mouse_down, movetoworkspace, e+1
    bind = SUPER SHIFT, mouse_up, movetoworkspace, e-1

    bind = SUPER, right, workspace, e+1
    bind = SUPER, left, workspace, e-1
    bind = SUPER SHIFT, right, movetoworkspace, e+1
    bind = SUPER SHIFT, left, movetoworkspace, e-1

    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
  '';
  misc = ''
    misc {
      vfr = true
      force_default_wallpaper = 0
      disable_hyprland_logo = true
    }
  '';
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = !cfg.withUWSM;
      extraConfig = ''
        ${layout}

        ${misc}

        ${appearance}

        ${input}

        ${binds}

        bind = SUPER, C, killactive,
        bind = SUPER, M, ${if cfg.withUWSM then "exec, uwsm stop" else "exit,"}
        bind = SUPER, V, togglefloating,
        bind = SUPER, P, pseudo,
        bind = SUPER, J, togglesplit,
        bind = SUPER, F, fullscreenstate, 2 0
        bind = SUPER, O, exec, hyprpicker

        ${
          with lib.strings;
          concatLines (
            map (
              cmd:
              let
                command = if (isString cmd) then cmd else concatStringsSep " " cmd;
              in
              "exec-once = ${run} ${command}"
            ) cfg.startup
          )
        }
        ${
          with lib.strings;
          concatLines (
            map (
              exec:
              let
                mod = concatMapStringsSep " " (mod: modifierMap.${mod}) exec.modifiers;
                options = concatStrings [
                  (optionalString (exec.description != null) "d")
                  (optionalString (exec.repeat) "e")
                  (optionalString (exec.locked) "l")
                ];
                description = optionalString (exec.description != null) ''"${exec.description}", '';
                rules =
                  let
                    contents = concatStrings [
                      (optionalString exec.float "float; ")
                    ];
                  in
                  optionalString (contents != "") "[ ${contents}]";
                command = if (isString exec.command) then exec.command else concatStringsSep " " exec.command;
              in
              "bind${options} = ${mod}, ${exec.bind}, ${description}exec, ${rules} ${run} ${command}"
            ) cfg.binds
          )
        }

        windowrule = suppressevent maximize, class:.*
        windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        windowrule = idleinhibit focus, fullscreen:1
      '';
    };

    programs.hyprlock = {
      enable = true;
    };

    services = {
      hyprpolkitagent.enable = true;
      # hypridle.enable = true;
    };

    home.packages = with pkgs; [
      hyprpicker
    ];
  };
}
