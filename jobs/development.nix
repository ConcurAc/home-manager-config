{ pkgs, ... }:
{
  home = {
    sessionVariables = {
      CARGO_HOME = "$HOME/.local/share/cargo";
      RUSTUP_HOME = "$HOME/.local/share/rustup";
    };
    packages = with pkgs; [
      rustup
    ];
  };
}
