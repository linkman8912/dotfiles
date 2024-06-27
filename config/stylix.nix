{ lib, inputs, pkgs, config, ...}:

{
	stylix = {
		enable = true;
		image = ./hyprpaper/purpleWallpaper.jpg;
		polarity = "dark";
		cursor = {
			size = 22;
		};
	};
}
