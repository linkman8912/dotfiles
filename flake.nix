{

  	description = "flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
		stylix.url = "github:danth/stylix";
  	};

  	outputs = { self, nixpkgs, home-manager, stylix, ... } @ inputs:
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				specialArgs = { inherit inputs; };
				inherit system;
				modules = [ 
				./configuration.nix
				/etc/nixos/hardware-configuration.nix
				inputs.stylix.nixosModules.stylix
				];
			};
		};
		homeConfigurations = {
			linkman = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix stylix.homeManagerModules.stylix ];
			};

		};
	};
}
