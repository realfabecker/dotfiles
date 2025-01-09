#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

info() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') saver: info:" $1
}

error() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') saver: error:" $1
}

from_bing() {
  info "Getting image of the day"
  DTA=$(curl  -s 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' | jq '.images[0]')
  URI=$(echo $DTA | jq -r '.url')
  JID=$(echo $DTA | jq -r '.hsh')
  SRC="https://bing.com$URI"
  PTH="$HOME/Imagens/Wallpapers/$JID"

  info "Downloading file from: $SRC"
  wget -q -O $PTH "$SRC"

  TYPE=$(identify $PTH | awk '{print tolower($2)}')
  PICT="$PTH.$TYPE"
  mv $PTH $PICT

  MTD="$HOME/Imagens/Wallpapers/$JID.json"
  info "Storing json metadata at: $MTD"
  echo "$DTA" > $MTD

  info "Changing background with gsettings to $PICT"
  gsettings set org.gnome.desktop.background picture-uri "file://$PICT"
}

from_rand() {	
  DIR="$HOME/Imagens/Wallpapers"
  info "Getting random wallpaper from $DIR"
  if [[ ! -d $DIR ]]; then
    error  "$DIR is not a valid directory"
    return
  fi

  PIC=$(realpath $(ls $DIR/*| grep -v .json | shuf -n1))
  if [[ ! -f "$PIC" ]]; then
    error "$PIC is not a valid file"
    return
  fi

  TYPE=$(echo $(file "$PIC" | cut -d " " -f 2))
  if [[ $TYPE != "JPEG" ]]; then
    error "$PIC is not a valid JPEG file"
    return
  fi

  info "Changing background with gsettings to $PIC"
  gsettings set org.gnome.desktop.background picture-uri "file://$PIC"
}

info "background changing"

if [[ $1 == "bing" ]]; then
  from_bing
  exit 0
fi

if [[ $1 == "rand" ]]; then
  from_rand
  exit 0
fi	

error "invalid saver mode"
exit 1
