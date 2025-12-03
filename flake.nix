
{
  description = "flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:nix-community/stylix/master";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs-droid.url = "nixpkgs/nixos-24.05";
    /*
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-droid";
      inputs.home-manager.follows = "home-manager-stable";
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    /*spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };*/
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

  outputs = { self, nixpkgs, home-manager, stylix, nixpkgs-stable, nixpkgs-droid, catppuccin, /*spicetify-nix,*/ nix-flatpak, nix-on-droid, chaotic, ... } @ inputs:
    let
    system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
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
          ./packages.nix
          /etc/nixos/hardware-configuration.nix
          inputs.stylix.nixosModules.stylix
          catppuccin.nixosModules.catppuccin
          {nixpkgs.overlays = [
            # inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
          nix-flatpak.nixosModules.nix-flatpak
          ./systems/default.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.linkman = {
                imports = [
                  ./home.nix
                  ./config/stylix.nix
                   catppuccin.homeModules.catppuccin
                   stylix.homeModules.stylix 
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
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
          ./packages.nix
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
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.linkman = {
                imports = [
                  ./home.nix
                  ./config/stylix.nix
                   catppuccin.homeModules.catppuccin
                   stylix.homeModules.stylix 
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
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
          ./packages.nix
		  /etc/nixos/hardware-configuration.nix
		  inputs.stylix.nixosModules.stylix
		  catppuccin.nixosModules.catppuccin
          {nixpkgs.overlays = [
            #inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/gtx1080.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.linkman = {
                imports = [
                  ./home.nix
                  ./config/stylix.nix
                   catppuccin.homeModules.catppuccin
                   stylix.homeModules.stylix 
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
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
          ./packages.nix
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
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.linkman = {
                imports = [
                  ./home.nix
                  ./config/stylix.nix
                   catppuccin.homeModules.catppuccin
                   stylix.homeModules.stylix 
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    homeserver = nixpkgs.lib.nixosSystem {
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
          ./packages.nix
          /etc/nixos/hardware-configuration.nix
          inputs.stylix.nixosModules.stylix
          catppuccin.nixosModules.catppuccin
          {nixpkgs.overlays = [
            #inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/homeserver.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.linkman = {
                imports = [
                  ./home.nix
                  ./config/stylix.nix
                   catppuccin.homeModules.catppuccin
                   stylix.homeModules.stylix 
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    liveIso = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        inherit system;
        modules = [ 
          ({ pkgs, modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
          })
          ./configuration.nix
          #/etc/nixos/hardware-configuration.nix
          inputs.stylix.nixosModules.stylix
          catppuccin.nixosModules.catppuccin
          {nixpkgs.overlays = [
            # inputs.hyprpanel.overlay
            inputs.neovim-nightly-overlay.overlays.default
          ];}
        nix-flatpak.nixosModules.nix-flatpak
          ./systems/default.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.linkman = {
                imports = [
                  ./home.nix
                  ./config/stylix.nix
                   catppuccin.homeModules.catppuccin
                   stylix.homeModules.stylix 
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };

    };

    /*homeConfigurations = {
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
    };*/
    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs-droid { system = "aarch64-linux"; };
      modules = [
        ./systems/nixOnDroid/configuration.nix
        <home-manager/nixos>
      ];
    }; 
  };
}
