{
  description = "flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix/master";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    suyu = {
      url = "git+https://github.com/Noodlez1232/suyu-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #ags.url = "github:Aylur/ags";
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, stylix, nixpkgs-stable, catppuccin, spicetify-nix, nix-flatpak, nix-on-droid, chaotic, ... } @ inputs:
    let
    system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  # nur = nur.legacyPackages.${system};
  in
  {
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
          {nixpkgs.overlays = [
            # inputs.hyprpanel.overlay
            #inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/default.nix
          chaotic.nixosModules.default
        ];
      };
      smartandgay = nixpkgs.lib.nixosSystem {
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
          {nixpkgs.overlays = [
            #inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/gtx980.nix
          chaotic.nixosModules.default
        ];
      };
      gtx1080 = nixpkgs.lib.nixosSystem {
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
          {nixpkgs.overlays = [
            #inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/gtx1080.nix
	    ];
      };
      dumbandgay = nixpkgs.lib.nixosSystem {
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
          {nixpkgs.overlays = [
            #inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/hplaptop.nix
          chaotic.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      linkman = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          stylix.homeModules.stylix 
          catppuccin.homeModules.catppuccin
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
    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {                               pkgs = import nixpkgs { system = "aarch64-linux"; };
      modules = [ ./systems/nixOnDroid/configuration.nix ];
    }; 
  };
}
