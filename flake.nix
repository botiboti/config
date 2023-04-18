{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    home-manager.url = github:nix-community/home-manager/release-22.11;
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
