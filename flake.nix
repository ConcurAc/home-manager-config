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

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      homeConfigurations.effigy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./users/connor
          ./modules/gaming.nix
          ./modules/music.nix
          ./modules/desktop/hyprland.nix
        ];
      };
      homeConfigurations.hub = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./users/connor
        ];
      };
    };
}
