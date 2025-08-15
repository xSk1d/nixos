{
  # A short description of your flake (optional)
  description = "NixOS + Home Manager (flake-only)";

  # "inputs" are all the sources your config depends on (like dependencies in other package managers)
  inputs = {
    # The official NixOS package set & modules, pinned to release 24.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    # Home Manager repo, also pinned to the release-24.05 branch
    home-manager.url = "github:nix-community/home-manager/release-24.05";

    # Makes Home Manager use the *same* nixpkgs version as above, so you don't get mismatched packages
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # "outputs" defines what this flake can produce (NixOS configs, packages, apps, etc.)
  outputs = { self, nixpkgs, home-manager, ... }:
  let
    # Architecture/CPU type we're building for (x86_64-linux = normal 64-bit PC)
    system = "x86_64-linux";
  in {
    # This is the set of NixOS configurations this flake can build
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system; # Pass the system architecture above

      # "modules" is the list of NixOS modules to load (like config files)
      modules = [
        ./configuration.nix   # Your main system config (hardware, services, etc.)
        home-manager.nixosModules.home-manager  # The Home Manager module
        {
          # This inline module tells Home Manager to use ./home.nix for your user
          home-manager.users.skid = import ./home.nix;
        }
      ];
    };
  };
}

