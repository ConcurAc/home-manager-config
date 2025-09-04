{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop;
  colors = config.lib.stylix.colors;

  modifierMap = {
    super = "Mod";
    shift = "Shift";
    alt = "Alt";
    ctrl = "Ctrl";
  };

  general = ''
    prefer-no-csd
    screenshot-path "~/Pictures/screenshots/%Y-%m-%d %H-%M-%S.png"
  '';

  layout = ''
    layout {
      gaps 16

      center-focused-column "on-overflow"

      preset-column-widths {
        proportion 0.25
        proportion 0.5
        proportion 0.75
      }

      border {
        width 2

        active-color "${colors.base0E}"
        inactive-color "${colors.base03}"
        urgent-color "${colors.base08}"
      }
    }
  '';

  input = ''
    input {
      keyboard {
        numlock
      }

      touchpad {
        natural-scroll
      }

      focus-follows-mouse max-scroll-amount="0%"
    }
  '';
in
{
  config = lib.mkIf cfg.enable {
    home.file."${config.xdg.configHome}/niri/config.kdl".text = ''
      ${general}
      ${layout}
      ${input}

      ${
        with lib.strings;
        concatLines (
          map (
            cmd:
            let
              script = isString cmd;
              action = if script then "spawn-sh-at-startup" else "spawn-at-startup";
              command =
                if script then
                  replaceString ''"'' ''\"'' cmd
                else
                  concatStringsSep ''" "'' (map (arg: replaceString ''"'' ''\"'' arg) cmd);
            in
            ''${action} "${command}"''
          ) cfg.startup
        )
      }

      binds {
        ${
          with lib.strings;
          concatLines (
            map (
              exec:
              let
                mod = concatStrings [
                  (concatMapStringsSep "+" (mod: modifierMap.${mod}) exec.modifiers)
                  (optionalString (builtins.length exec.modifiers > 0) "+")
                ];
                options = concatStrings [
                  (optionalString (exec.description != null) ''hotkey-overlay-title="${exec.description}" '')
                  (optionalString (!exec.repeat) "repeat=false ")
                  (optionalString (exec.locked) "allow-when-locked=true ")
                ];
                script = isString exec.command;
                action = if script then "spawn-sh" else "spawn";
                command =
                  if script then
                    replaceString ''"'' ''\"'' exec.command
                  else
                    concatStringsSep ''" "'' (map (arg: replaceString ''"'' ''\"'' arg) exec.command);
                rules = concatStrings [
                  ''${action} "${command}"''
                ];
              in
              "  " + ''${mod}${exec.bind} ${options}{ ${rules}; }''
            ) cfg.binds
          )
        }

        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+O repeat=false { toggle-overview; }

        Mod+Q { close-window; }

        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }

        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Down  { move-window-down; }
        Mod+Ctrl+Up    { move-window-up; }
        Mod+Ctrl+Right { move-column-right; }
        Mod+Ctrl+H     { move-column-left; }
        Mod+Ctrl+J     { move-window-down; }
        Mod+Ctrl+K     { move-window-up; }
        Mod+Ctrl+L     { move-column-right; }

        Mod+Home { focus-column-first; }
        Mod+End  { focus-column-last; }
        Mod+Ctrl+Home { move-column-to-first; }
        Mod+Ctrl+End  { move-column-to-last; }

        Mod+Shift+Left  { focus-monitor-left; }
        Mod+Shift+Down  { focus-monitor-down; }
        Mod+Shift+Up    { focus-monitor-up; }
        Mod+Shift+Right { focus-monitor-right; }
        Mod+Shift+H     { focus-monitor-left; }
        Mod+Shift+J     { focus-monitor-down; }
        Mod+Shift+K     { focus-monitor-up; }
        Mod+Shift+L     { focus-monitor-right; }

        Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
        Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
        Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        Mod+Shift+Page_Down { move-workspace-down; }
        Mod+Shift+Page_Up   { move-workspace-up; }
        Mod+Shift+U         { move-workspace-down; }
        Mod+Shift+I         { move-workspace-up; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight      { focus-column-right; }
        Mod+WheelScrollLeft       { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft  { move-column-left; }

        Mod+Shift+WheelScrollDown      { focus-column-right; }
        Mod+Shift+WheelScrollUp        { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        Mod+Tab { focus-workspace-previous; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        Mod+Comma  { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        Mod+Ctrl+F { expand-column-to-available-width; }

        Mod+C { center-column; }

        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }

        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V       { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Mod+Space       { switch-layout "next"; }
        Mod+Shift+Space { switch-layout "prev"; }

        Print { screenshot show-pointer=false; }
        Ctrl+Print { screenshot-screen show-pointer=false; }
        Alt+Print { screenshot-window; }

        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }

        Mod+Shift+P { power-off-monitors; }
      }

      window-rule {
        match app-id=r#"^org\.keepassxc\.KeePassXC$"#
        match app-id=r#"^org\.gnome\.World\.Secrets$"#

        block-out-from "screen-capture"
      }

      window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
      }
    '';

    home.packages = with pkgs; [
      niri
    ];
  };
}
