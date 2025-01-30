{ config, pkgs, lib, inputs, ... }:

{
  config = {
    home = {
      # Home Manager needs a bit of information about you and the paths it should
      # manage.
      username = "linkman";
	  homeDirectory = "/home/linkman";
	
	  # This value determines the Home Manager release that your configuration is
	  # compatible with. This helps avoid breakage when a new Home Manager release
	  # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
	  # want to update the value, then make sure to first check the Home Manager
	  # release notes.
	  stateVersion = "24.05"; # Please read the comment before changing.
		
      # The home.packages option allows you to install Nix packages into your
	  # environment.
	  packages = [
	  	# # Adds the 'hello' command to your environment. It prints a friendly
		# # "Hello, world!" when run.
	    pkgs.hello
		pkgs.cowsay 
		pkgs.fortune
		
		# # It is sometimes useful to fine-tune packages, for example, by applying
		# # overrides. You can do that directly here, just don't forget the
		# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
		# # fonts?
		# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

		# # You can also create simple shell scripts directly inside your
		# # configuration. For example, this adds a command 'my-hello' to your
		# # environment:
		# (pkgs.writeShellScriptBin "my-hello" ''
		#   echo "Hello, ${config.home.username}!"
		# '')
	  ];
	
  	  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  	  # plain files is through 'home.file'.
  	  file = {
  	    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    	# # the Nix store. Activating the configuration will then make '~/.screenrc' a
    	# # symlink to the Nix store copy.
    	# ".screenrc".source = dotfiles/screenrc;
		
		".config/waybar/style.css".source = ./config/waybar/style.css;
		".config/waybar/config.jsonc".source = ./config/waybar/config.jsonc;
		".config/waybar/mocha.css".source = ./config/waybar/mocha.css;
		".config/waybar/colors.css".source = ./config/waybar/colors.css;
		# ".icons".source = ./config/hypr/hyprcursor;
		".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
		".config/hypr/mocha.conf".source = ./config/hypr/mocha.conf;
		".config/hypr/hyprlock.conf".source = ./config/hypr/hyprlock.conf;
		".config/background.png".source = ./config/hypr/background.png;
		".face".source = ./config/hypr/hyprpaper/Biden.png;
		".config/hypr/hypridle.conf".source = ./config/hypr/hypridle.conf;
        ".config/btop/themes/catppuccin_mocha.theme".source = ./config/btop_catppuccin_mocha.theme;
		
		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
    	#   org.gradle.console=verbose
    	#   org.gradle.daemon.idletimeout=3600000
    	# '';
	  };	
	};

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
	  "spotify"
	];

	programs = {
	  bash = {
		enable = true;
		shellAliases = {
		  "ls" = "ls -A --color=always";
		  "ll" = "ls -slak";
		  "l" = "ls -A --color=always";
		  ".." = "z ..";
		  "..." = "z ../..";
		  "...." = "z ../../..";
		  "calculator" = "python -q";
		};
				
		initExtra = 
		''
		  # fastfetch
		  # eval "$(zoxide init bash)"
	
		  if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
	      then
	      	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      		exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    	  fi
		'';
				
		};
	
		neovim = {
		  enable = true;
		  vimAlias = true;
		  defaultEditor = true;
		  plugins = with pkgs.vimPlugins; [
		    lazy-nvim
	  	  ];
		  catppuccin.enable = true;
		  extraConfig =
          ''
			set mouse =
			set tabstop=4
			set shiftwidth=2
			set autoindent
			set expandtab
		  '';
		};
	
		git = {
		  enable = true;
		  userName  = "linkman";
		  userEmail = "linkman8912@proton.me";
		};
			
		kitty = {
		  enable = true;
		  catppuccin.enable = true;
		  extraConfig =
          ''
			window_title_format {title}
			cursor_shape block
			shell_integration no-cursor
		  '';
		  font = {
			name = lib.mkForce "SauceCodePro Nerd Font Mono";
			size = 12;
		  };
		};
		spicetify = 
		  let
			spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
		  in
		  {
			enable = true;
			enabledExtensions = with spicePkgs.extensions; [
			  adblock
			  shuffle # shuffle+ (special characters are sanitized out of extension names)
			  bookmark
			  fullAppDisplay
			  lastfm
			  keyboardShortcut
			  loopyLoop
			  popupLyrics
			  fullAlbumDate
			];
			enabledCustomApps = with spicePkgs.apps; [
			  lyricsPlus
			  marketplace
			  localFiles
			];
			theme = spicePkgs.themes.catppuccin;
			colorScheme = "mocha";
		  };
		  fish = {
			enable = true;
			interactiveShellInit =
            ''
      		  set fish_greeting # Disable greeting
			  hyfetch -b fastfetch
			  zoxide init fish | source
	    	'';
			shellAliases = {
			  "ls" = "ls -A --color=auto";
			  "ll" = "ls -slak";
			  "l" = "ls -A --color=auto";
			  ".." = "z ..";
			  "..." = "z ../..";
			  "...." = "z ../../..";
              "v" = "nvim";
              "unpack" = "unp -U";
			};
		  };
		  fuzzel = {
		    enable = true;
			catppuccin.enable = true;
		  };
		  home-manager.enable = true;
		};
		services.hyprpaper = {
		  enable = true;
		  settings = {
			preload = 
			[
			  "~/.dotfiles/config/hypr/hyprpaper/purpleWallpaper.jpg"
			  "~/.dotfiles/config/hypr/hyprpaper/bnwWallpaper.jpg"
			  "~/.dotfiles/config/hypr/hyprpaper/pixel-car.png"
              "~/.dotfiles/config/hypr/hyprpaper/aesthetic.jpg"
			];
			wallpaper = [ ", ~/.dotfiles/config/hypr/hyprpaper/aesthetic.jpg" ];
		  };
		};
		catppuccin = {
		  enable = true;
		  flavor = "mocha";
		};
	};
		
	imports = [
	  # ./config/hypr/hyprland.nix
	  ./config/stylix.nix
	  ~/.envars.nix
	  inputs.spicetify-nix.homeManagerModules.default
      inputs.ags.homeManagerModules.default
	];
}
