{
  description = "Home Manager configuration";

  inputs = {
    nixos.url = "path:/etc/nixos";
    nixpkgs.follows = "nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.follows = "nixos/stylix";
    sops-nix.follows = "nixos/sops-nix";
    retrom.follows = "nixos/retrom";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      sops-nix,
      stylix,
      retrom,
      ...
    }:
    let
      modules = import ./modules;
    in
    {
      homeConfigurations = {
        "connor@effigy" =
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit inputs modules;
            };

            modules = [
              sops-nix.homeModules.sops
              stylix.homeModules.stylix
              retrom.homeModules.retrom

              ./hosts/effigy
              ./home.nix
            ];
          };

        "connor@opus" =
          let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit inputs modules;
            };

            modules = [
              sops-nix.homeModules.sops
              stylix.homeModules.stylix
              retrom.homeModules.retrom

              ./hosts/opus
              ./home.nix
            ];
          };
      };
    };
}
