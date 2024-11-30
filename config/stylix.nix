{ lib, inputs, pkgs, config, pkgs-stable, ...}:

{
	stylix = {
		enable = true;
		image = ./hypr/hyprpaper/pixel-car.png;
		base16Scheme = "${pkgs-stable.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		polarity = "dark";
		cursor = {
			size = 30;
			name = "Banana-Blue";
		};
	};
}
