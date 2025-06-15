#!/usr/bin/env sh

read -p "enter access token: " token
for i in "$@"; do
  curl --request GET \
    --url "https://api.spotify.com/v1/albums/3VoX4iyvy7et6Qt47e2XwS?market=US" \
    --header "Authorization: Bearer $token"
  spotdl --lyrics synced --generate-lrc "$i"
