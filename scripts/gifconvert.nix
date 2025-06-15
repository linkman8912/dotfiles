with import <nixpkgs> {};

/*writeShellScriptBin "gifconvert" ''
palette="/tmp/palette.png"
filters="fps=15,scale=1920:-1:flags=lanczos"
if [$3 && $4]; then
  ffmpeg -i $1 \
    -ss $3 -t $4 \
    -vf "$filters,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $2
elif [$3]; then
  ffmpeg -i $1 \
    -ss $3 \
    -vf "$filters,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $2
else
  ffmpeg -i $1 \
    -vf "$filters,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $2
fi
''*/

writeShellScriptBin "gifconvert" ./gifconvert.sh
