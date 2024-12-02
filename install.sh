#!/usr/bin/env bash
set -e

# bash message log with info format
info() {
  command printf '\033[1;32m%12s\033[0m %s\n' "$1" "$2" 1>&2
}

# bash message log with erro format
error() {
  command printf '\033[1;31mError\033[0m: %s\n\n' "$1" 1>&2
}

info "Cleaning" "cleaning previous artifacts"
rm -rf /tmp/dotfiles && mkdir -p /tmp/dotfiles

info "Downloading" "downloading source tarball"
curl -L --output /tmp/dotfiles/dotfiles.tar.gz $(curl -s https://api.github.com/repos/realfabecker/dotfiles/releases/latest | grep tarball_url | cut -d '"' -f 4)

info "Extracting" "extracting tarball in tmp"
tar -xvf /tmp/dotfiles/dotfiles.tar.gz -C /tmp/dotfiles --strip-components=1

info "Installing" "installing with ansible"
bash /tmp/dotfiles/ansible/ansible.install.sh

info "Completed" "link installation"
