#!/bin/bash

from_bing() {
  echo "Getting image of the day"
  DTA=$(curl  -s 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' | jq '.images[0]')
  URI=$(echo $DTA | jq -r '.url')
  JID=$(echo $DTA | jq -r '.hsh')
  SRC="https://bing.com$URI"
  PTH="$HOME/Imagens/Wallpapers/$JID"

  echo "Downloading file from: $SRC"
  wget -q -O $PTH "$SRC"

  TYPE=$(identify $PTH | awk '{print tolower($2)}')
  PICT="$PTH.$TYPE"
  mv $PTH $PICT

  MTD="$HOME/Imagens/Wallpapers/$JID.json"
  echo "Storing json metadata at: $MTD"
  echo "$DTA" > $MTD

  echo "Changing background with gsettings to $PIC"
  gsettings set org.gnome.desktop.background picture-uri "file://$PICT"
}

from_rand() {	
  DIR="$HOME/Imagens/Wallpapers"
  echo "Getting random wallpaper from $DIR"
  if [[ ! -d $DIR ]]; then
    echo "saver: $DIR is not a valid directory"
    exit 1
  fi

  PIC=$(realpath $(ls $DIR/*| grep -v .json | shuf -n1))
  if [[ ! -f "$PIC" ]]; then
    echo "saver: $PIC is not a valid file"
    exit 1
  fi

  TYPE=$(echo $(file "$PIC" | cut -d " " -f 2))
  if [[ $TYPE != "JPEG" ]]; then
    echo "saver: $PIC is not a valid JPEG file"
    exit 1
  fi

  echo "Changing background with gsettings to $PIC"
  gsettings set org.gnome.desktop.background picture-uri "file://$PIC"
}

if [[ $1 == "bing" ]]; then
  from_bing
  exit 0
fi

if [[ $1 == "rand" ]]; then
  from_rand
  exit 0
fi

echo "err: invalid saver mode"
exit 1
