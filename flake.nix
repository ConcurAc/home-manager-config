{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      homeConfigurations.connor = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./users/connor
          ./modules/desktop/hyprland.nix
        ];
      };
    };
}
