#!/bin/bash

playerctl -l |
gawk '
  BEGIN {
    printf "["
  }
    {
      printf "\"%s\",", $1
    }
  END {
    printf "]"
  }' | 
gawk '
  {b=gensub(/.\]/,"]","g",$0); print b}'| jaq -c '.' 
