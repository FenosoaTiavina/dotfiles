#!/bin/bash

skip_amount=0.05

notify-send "$3"

if [ "$2" == "up" ] ; then
  playerctl -i firefox $1 $skip_amount+
elif [ "$2" == "down" ]; then
  if [ $3 > 0 ] ; then
    playerctl -i firefox $1 $skip_amount-
  fi
fi
