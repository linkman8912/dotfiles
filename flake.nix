{

  	description = "flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
		stylix.url = "github:danth/stylix/release-24.05";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  	};

  	outputs = { self, nixpkgs, home-manager, stylix, nixpkgs-unstable, ... } @ inputs:
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
			pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				specialArgs = {
					inherit inputs;
					pkgs-unstable = import nixpkgs-unstable {
						inherit system;
						config.allowUnfree = true;
					};
				};
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
