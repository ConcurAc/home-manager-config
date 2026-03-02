{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      CARGO_HOME = "~/.local/share/cargo";
      RUSTUP_HOME = "~/.local/share/rustup";
    };
    packages = with pkgs; [
      rustup
    ];
  };
}
