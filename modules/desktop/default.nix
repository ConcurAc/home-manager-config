{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./niri.nix
  ];

  options.desktop = with lib; {
    enable = mkEnableOption "Enable custom desktop setup.";
    withUWSM = mkEnableOption "Configure for use with uwsm.";

    startup = mkOption {
      type = types.listOf (types.either types.str (types.listOf types.str));
      description = "Commands executed on startup.";
      default = [ ];
    };

    binds = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            description = mkOption {
              type = types.nullOr types.str;
              description = "Description of the command.";
              default = null;
            };
            command = mkOption {
              type = types.either types.str (types.listOf types.str);
              description = "Command to be executed.";
            };
            bind = mkOption {
              type = types.str;
            };
            modifiers = mkOption {
              type = types.listOf (
                types.enum [
                  "super"
                  "shift"
                  "alt"
                  "ctrl"
                ]
              );
              default = [ ];
            };

            repeat = mkEnableOption "Repeat command while held";
            locked = mkEnableOption "Allow command while desktop is locked.";

            float = mkEnableOption "Floats window when run.";
          };
        }
      );
    };
  };
}
