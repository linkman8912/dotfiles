{ lib, inputs, pkgs, config, /*pkgs-stable,*/ ...}:

{
	stylix = {
		enable = true;
		image = ./hypr/hyprpaper/shaded.png;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		polarity = "dark";
	};
}
