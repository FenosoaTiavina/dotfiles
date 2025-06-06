#!/bin/bash

IMAGE=""

while true ;do
  NEW_IMAGE=$(playerctl -i firefox metadata mpris:artUrl)
  # NEW_IMAGE=$(eww get now_playing_image)
  if [[ $IMAGE != $NEW_IMAGE ]];then
    eww update load_player_background=false
    echo "player background updated"
    IMAGE=$NEW_IMAGE
    magick $IMAGE -filter Gaussian -blur 0x2 scripts/blur_image_name.jpeg
    eww update player_blured_image='scripts/blur_image_name.jpeg'
    eww update load_player_background=true

    last_image=$NEW_IMAGE
    eww update last_image=$last_image
  fi
  # eww update reload_style='opacity:0;'
  # echo $IMAGE

  sleep 1
done
