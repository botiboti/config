{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.toty = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./configuration.nix
        ./toty.nix
      ];
    };
    nixosConfigurations.tot = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./configuration.nix
        ./tot.nix
      ];
    };
    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      	inputs.home-manager.nixosModules.home-manager
      	./configuration.nix
      	./thinkpad.nix
      ];	
    };
  };

}
