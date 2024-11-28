#!/usr/bin/env fish
if test -b "~/night-city.gif"
	echo "night-city.gif exists"
else
	ffmpeg -i ~/.dotfiles/config/hypr/hyprpaper/night-city.mp4 -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 ~/night-city.gif
	echo "night-city.gif created"
end
if test -b "~/pixel-car.gif"
	echo "pixel-car.gif exists"
else
	ffmpeg -i ~/.dotfiles/config/hypr/hyprpaper/pixel-car.mp4 -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 ~/pixel-car.gif
	echo "pixel-car.gif created"
end
echo "ok"
