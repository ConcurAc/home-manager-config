{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.development;
in
{
  options.features.development = {
    rust = {
      enable = lib.mkEnableOption "Configure rust development toolchain";
      cargoHome = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.local/share/cargo";
      };
      rustupHome = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.local/share/rustup";
      };
    };
    go = {
      enable = lib.mkEnableOption "Configure go development toolchain";
    };
    arduino = {
      enable = lib.mkEnableOption "Configure arduino development toolchain";
      arduinoHome = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.local/share/arduino";
      };
    };
  };

  config = {
    home = {
      sessionVariables = {
        CARGO_HOME = cfg.rust.cargoHome;
        RUSTUP_HOME = cfg.rust.rustupHome;
        ARDUINO_DIRECTORIES_DATA = cfg.arduino.arduinoHome;
      };
      packages =
        (lib.optional (cfg.rust.enable) pkgs.cargo)
        ++ (lib.optional (cfg.go.enable) pkgs.go)
        ++ (lib.optional (cfg.arduino.enable) pkgs.arduino-cli);
    };
  };
}
