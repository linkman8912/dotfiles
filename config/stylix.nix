{ lib, inputs, pkgs, config, ...}:

{
	stylix = {
		enable = true;
		image = ./hypr/hyprpaper/pixel-car.png;
		# base16Scheme = "~/.dotfiles/config/hypr/hyprpaper/catppuccin-mocha.yaml";
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		polarity = "dark";
		cursor = {
			size = 30;
			name = "Banana-Blue";
		};
	};
}
