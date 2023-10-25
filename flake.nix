{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    home-manager.url = github:nix-community/home-manager/release-23.05;
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.toty = nixpkgs.lib.nixosSystem {
      # Note that you cannot put arbitrary configuration here: the configuration must be placed in the files loaded via modules
      system = "x86_64-linux";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./configuration.nix
      ];
    };
  };

}
