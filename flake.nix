{
  	description = "flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
		stylix.url = "github:danth/stylix/release-24.05";
		nixpkgs-stable.url = "nixpkgs/nixos-24.05";
		zen-browser.url = "github:MarceColl/zen-browser-flake";
		catppuccin.url = "github:catppuccin/nix";
		spicetify-nix = {
      			url = "github:Gerg-L/spicetify-nix";
      			inputs.nixpkgs.follows = "nixpkgs";
    		};
  	};

  	outputs = { self, nixpkgs, home-manager, stylix, nixpkgs-stable, catppuccin, spicetify-nix, ... } @ inputs:
		let
			system = "x86_64-linux";
		
			pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				specialArgs = {
					inherit inputs;
					pkgs-stable = import nixpkgs-stable {
						inherit system;
						config.allowUnfree = true;
					};
				};
				inherit system;
				modules = [ 
					./configuration.nix
					/etc/nixos/hardware-configuration.nix
					inputs.stylix.nixosModules.stylix
					catppuccin.nixosModules.catppuccin
				];
			};
		};
		homeConfigurations = {
			linkman = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
					./home.nix
					stylix.homeManagerModules.stylix 
					catppuccin.homeManagerModules.catppuccin
				];
				extraSpecialArgs = {
					inherit inputs;
					pkgs-stable = import nixpkgs-stable {
						inherit system;
						config.allowUnfree = true;
					};
				};

			};

		};

	};
}
