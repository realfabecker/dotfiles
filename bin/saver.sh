#!/bin/bash

DIR="$HOME/Imagens"
if [[ ! -d $DIR ]]; then
  echo "saver: $DIR is not a valid directory"
  exit 1
fi

PIC=$(realpath $(ls $DIR/*| shuf -n1))
if [[ ! -f "$PIC" ]]; then
  echo "saver: $PIC is not a valid file"
  exit 1
fi

TYPE=$(echo $(file "$PIC" | cut -d " " -f 2))
if [[ $TYPE != "JPEG" ]]; then
  echo "saver: $PIC is not a valid JPEG file"
  exit 1
fi

gsettings set org.gnome.desktop.background picture-uri "file://$PIC"