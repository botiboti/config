{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.toty = nixpkgs.lib.nixosSystem {
      # Note that you cannot put arbitrary configuration here: the configuration must be placed in the files loaded via modules
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
      ];
    };
  };

}
