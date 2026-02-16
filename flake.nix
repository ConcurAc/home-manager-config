{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    retrom = {
      url = "github:concurac/retrom/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,

      home-manager,
      sops-nix,
      stylix,
      nixvim,
      retrom,
      ...
    }:
    {
      homeConfigurations = {
        "connor@effigy" =
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
            pkgs-stable = import nixpkgs-stable { inherit system; };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit pkgs-stable;
            };

            modules = [
              sops-nix.homeModules.sops
              stylix.homeModules.stylix
              nixvim.homeModules.nixvim
              retrom.homeModules.retrom

              ./hosts/effigy
              ./home.nix
            ];
          };

        "connor@opus" =
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
            pkgs-stable = import nixpkgs-stable { inherit system; };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit pkgs-stable;
            };

            modules = [
              sops-nix.homeModules.sops
              stylix.homeModules.stylix
              nixvim.homeModules.nixvim

              ./hosts/opus
              ./home.nix
            ];
          };
      };
    };
}
