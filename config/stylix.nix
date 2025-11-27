{ lib, inputs, pkgs, config, /*pkgs-stable,*/ ...}:

{
	stylix = {
		enable = true;
		image = ./hypr/hyprpaper/pixel-car.png;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		polarity = "dark";
	};
}
