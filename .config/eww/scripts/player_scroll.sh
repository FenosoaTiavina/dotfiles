#!/bin/bash

skip_amount=0.1


if [ "$2" == "up" ] ; then
  playerctl -i firefox $1 $skip_amount+
elif [ "$2" == "down" ]; then
  playerctl -i firefox $1 $skip_amount-
fi
