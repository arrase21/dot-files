#!/usr/bin/env bash

# @requires: pactl

if [[ $1 == "status" ]]; then
  if [[ $(amixer get Capture | grep '\[off\]') = '' ]]; then
    echo yes
  else
    echo no
  fi
fi

if [[ $1 == "toggle" ]]; then
  amixer set Capture toggle  
fi
Footer
