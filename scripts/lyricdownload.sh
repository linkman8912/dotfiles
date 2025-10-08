#!/usr/bin/env fish

#$SONGS = *
for SONG in *;
  if (echo $SONG | grep flac)
    syncedlyrics (echo "$SONG" | sed -e "s/.flac//g" -e "s/'//g" -e "s/\"//g")
  end
end
