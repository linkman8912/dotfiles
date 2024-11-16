{ lib, inputs, pkgs, config, ...}:

{
	stylix = {
		enable = true;
		image = ./hypr/hyprpaper/purpleWallpaper.jpg;
		polarity = "dark";
		cursor = {
			size = 30;
			name = "Banana-Tokyo-Night-Storm";
		};
	};
}
