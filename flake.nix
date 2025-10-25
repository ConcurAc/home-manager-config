{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      nixvim,
      niri,
      ...
    }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      homeConfigurations.connor = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          stylix.homeModules.stylix
          nixvim.homeModules.nixvim
          niri.homeModules.niri

          ./home.nix
        ];
      };
    };
}
