#!/usr/bin/env fish
mkdir $XDG_CONFIG_HOME/wallpapers
if test -b "$XDG_CONFIG_HOME/wallpapers/night-city.gif"
	echo "night-city.gif exists"
else
	ffmpeg -i ~/.dotfiles/config/hypr/hyprpaper/night-city.mp4 -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 $XDG_CONFIG_HOME/wallpapers/night-city.gif
	echo "night-city.gif created"
end
if test -b "$XDG_CONFIG_HOME/wallpapers/pixel-car.gif"
	echo "pixel-car.gif exists"
else
	ffmpeg -i ~/.dotfiles/config/hypr/hyprpaper/pixel-car.mp4 -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 $XDG_CONFIG_HOME/wallpapers/pixel-car.gif
	echo "pixel-car.gif created"
end
if test -b "$XDG_CONFIG_HOME/wallpapers/goodmorningnightcity.webm"
	echo "goodmorningnightcity.gif exists"
else
    yt-dlp 'https://youtu.be/srtbmP_WJgY?si=oewz2REjOP33oLp3' --output=$XDG_CONFIG_HOME/wallpapers/goodmorningnightcity.webm
	echo "goodmorningnightcity.gif created"
end
if test -b "$XDG_CONFIG_HOME/wallpapers/goodmorningnightcity.gif"
	echo "goodmorningnightcity.gif exists"
else
	ffmpeg -i '$XDG_CONFIG_HOME/wallpapers/goodmorningnightcity.webm' -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 $XDG_CONFIG_HOME/wallpapers/goodmorningnightcity.gif
	echo "goodmorningnightcity.gif created"
end
echo "ok"
