#!/usr/bin/env fish
mkdir ~/.wallpapers
if test -b "~/.wallpapers/night-city.gif"
	echo "night-city.gif exists"
else
	ffmpeg -i ~/.dotfiles/config/hypr/hyprpaper/night-city.mp4 -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 ~/.wallpapers/night-city.gif
	echo "night-city.gif created"
end
if test -b "~/.wallpapers/pixel-car.gif"
	echo "pixel-car.gif exists"
else
	ffmpeg -i ~/.dotfiles/config/hypr/hyprpaper/pixel-car.mp4 -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 ~/.wallpapers/pixel-car.gif
	echo "pixel-car.gif created"
end
if test -b "~/.wallpapers/goodmorningnightcity.webm"
	echo "goodmorningnightcity.gif exists"
else
    yt-dlp 'https://youtu.be/srtbmP_WJgY?si=oewz2REjOP33oLp3' --output=~/.wallpapers/goodmorningnightcity.webm
	echo "goodmorningnightcity.gif created"
end
if test -b "~/.wallpapers/goodmorningnightcity.gif"
	echo "goodmorningnightcity.gif exists"
else
	ffmpeg -i '~/.wallpapers/goodmorningnightcity.webm' -vf "fps=30,scale=1920:-1:flags=lanczos" -loop 0 ~/.wallpapers/goodmorningnightcity.gif
	echo "goodmorningnightcity.gif created"
end
echo "ok"
