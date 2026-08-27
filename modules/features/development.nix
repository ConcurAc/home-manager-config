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
      enableLSP = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
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
      enableLSP = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
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
        CARGO_HOME = lib.mkIf cfg.rust.enable cfg.rust.cargoHome;
        RUSTUP_HOME = lib.mkIf cfg.rust.enable cfg.rust.rustupHome;
        ARDUINO_DIRECTORIES_DATA = lib.mkIf cfg.arduino.enable cfg.arduino.arduinoHome;
      };
      packages =
        (lib.optional (cfg.rust.enable) pkgs.cargo)
        ++ (lib.optional (cfg.rust.enable && cfg.rust.enableLSP) pkgs.rust-analyzer)
        ++ (lib.optional (cfg.go.enable) pkgs.go)
        ++ (lib.optional (cfg.go.enable && cfg.go.enableLSP) pkgs.gopls)
        ++ (lib.optional (cfg.arduino.enable) pkgs.arduino-cli);
    };
  };
}
