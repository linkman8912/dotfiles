#!/usr/bin/env sh

#for filename in $1; do 
  #if ls -f "$filename" ; then
#    ffmpeg -i "${filename}" -i $2 -map_metadata 0 -map 1 -acodec copy "${3}${filename}"
  #fi
#done

find old/ -maxdepth 1 -type f -exec ffmpeg -i {} -i cover.png -map_metadata 0 -map 1 -acodec copy new/{} \;
