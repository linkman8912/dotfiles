{ lib, inputs, pkgs, config, ...}:

{
	stylix = {
		enable = true;
		image = ./hypr/hyprpaper/pixel-car.png;
		polarity = "dark";
		cursor = {
			size = 30;
			name = "Banana-Blue";
		};
	};
}
