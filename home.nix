{ config, pkgs, ... }:

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
  	home.username = "linkman";
  	home.homeDirectory = "/home/linkman";

	 # home.pointerCursor = {
	 #	gtk.enable = true;
	 #	name = "Banana-Tokyo-Night-Storm";
	 #	size = 30;
	 #};

  	# This value determines the Home Manager release that your configuration is
  	# compatible with. This helps avoid breakage when a new Home Manager release
  	# introduces backwards incompatible changes.
  	#
  	# You should not change this value, even if you update Home Manager. If you do
  	# want to update the value, then make sure to first check the Home Manager
  	# release notes.
  	home.stateVersion = "24.05"; # Please read the comment before changing.

  	# The home.packages option allows you to install Nix packages into your
  	# environment.
  	home.packages = [
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
  	home.file = {
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

    		# # You can also set the file content immediately.
    		# ".gradle/gradle.properties".text = ''
    		#   org.gradle.console=verbose
    		#   org.gradle.daemon.idletimeout=3600000
    		# '';
  	};

  	# Home Manager can also manage your environment variables through
  	# 'home.sessionVariables'. These will be explicitly sourced when using a
  	# shell provided by Home Manager. If you don't want to manage your shell
  	# through Home Manager then you have to manually source 'hm-session-vars.sh'
  	# located at either
  	#
  	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  	#
  	# or
  	#
  	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  	#
  	# or
  	#
  	#  /etc/profiles/per-user/linkman/etc/profile.d/hm-session-vars.sh
  	#
  	home.sessionVariables = {
    		# EDITOR = "emacs";
  	};
	programs = {
		bash = {
			enable = true;
			shellAliases = {
				"ls" = "ls -A";
				".." = "z ..";
				"..." = "z ../..";
				"calculator" = "python -q";
			};
			
			initExtra = 
			''
				fastfetch
				eval "$(zoxide init bash)"
			'';
		};

		neovim = {
			enable = true;
			vimAlias = true;
			defaultEditor = true;
		};

		git = {
			enable = true;
			userName  = "linkman";
			userEmail = "linkman8912@proton.me";
		};
	};
	services.hyprpaper = {
		enable = true;
		settings = {
			preload = 
				[
				"~/.dotfiles/config/hypr/hyprpaper/purpleWallpaper.jpg"
				"~/.dotfiles/config/hypr/hyprpaper/bnwWallpaper.jpg"
				"~/.dotfiles/config/hypr/hyprpaper/pixel-car.png"
				];

			wallpaper = 
			[ ", ~/.dotfiles/config/hypr/hyprpaper/pixel-car.png" ];
		};
	};

	imports = [
		# ./config/hypr/hyprland.nix
		./config/stylix.nix
	];

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
