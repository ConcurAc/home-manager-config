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
    cpp = {
      enable = lib.mkEnableOption "Configure C++ development toolchain";
      enableLSP = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
    rust = {
      enable = lib.mkEnableOption "Configure Rust development toolchain";
      enableLSP = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      cargoHome = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.cargo";
      };
      rustupHome = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.rustup";
      };
    };
    go = {
      enable = lib.mkEnableOption "Configure Go development toolchain";
      enableLSP = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      goPath = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/go";
      };
      goModCache = lib.mkOption {
        type = lib.types.str;
        default = "$GOPATH/pkg/mod";
      };
    };
    arduino = {
      enable = lib.mkEnableOption "Configure arduino development toolchain";
      arduinoData = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/Arduino";
      };
    };
    esp = {
      enable = lib.mkEnableOption "Configure ESP development toolchain";
      exportFile = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/export-esp.sh";
      };
      aliasExport = lib.mkEnableOption "Enable ESP environment script";
    };
  };

  config = {
    home = {
      sessionVariables = {
        CARGO_HOME = lib.mkIf cfg.rust.enable cfg.rust.cargoHome;
        RUSTUP_HOME = lib.mkIf cfg.rust.enable cfg.rust.rustupHome;
        GOPATH = lib.mkIf cfg.go.enable cfg.go.goPath;
        GOMODCACHE = lib.mkIf cfg.go.enable cfg.go.goModCache;
        ARDUINO_DIRECTORIES_DATA = lib.mkIf cfg.arduino.enable cfg.arduino.arduinoData;
        ESPUP_EXPORT_FILE = lib.mkIf cfg.esp.enable cfg.esp.exportFile;
      };
      packages =
        (lib.optional (cfg.rust.enable) pkgs.cargo)
        ++ (lib.optional (cfg.rust.enable && cfg.rust.enableLSP) pkgs.rust-analyzer)
        ++ (lib.optional (cfg.cpp.enable) pkgs.clang)
        ++ (lib.optional (cfg.cpp.enable && cfg.cpp.enableLSP) pkgs.clang-analyzer)
        ++ (lib.optional (cfg.go.enable) pkgs.go)
        ++ (lib.optional (cfg.go.enable && cfg.go.enableLSP) pkgs.gopls)
        ++ (lib.optional (cfg.arduino.enable) pkgs.arduino-cli)
        ++ (lib.optionals (cfg.esp.enable) (
          with pkgs;
          [
            espup
            espflash
            ldproxy
          ]
        ));
      shellAliases = {
        export-esp = ". \"${cfg.esp.exportFile}\"";
      };
    };
  };
}
