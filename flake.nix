{
  description = "NixOS + Home Manager (flake-only)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system; 

      modules = [
        ./configuration.nix   
        home-manager.nixosModules.home-manager  
        {
          home-manager.users.skid = import ./home.nix;
        }
      ];
    };
  };
}

