#!/usr/bin/env fish

#$SONGS = *
for SONG in *;
    syncedlyrics (echo "$SONG" | sed -e "s/.flac//g" -e "s/'//g" -e "s/\"//g")
end
