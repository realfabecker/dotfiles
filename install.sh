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

# bashy install with git clone
bashy_install() {
  info "Downloading" "release from github ${repo_url}"
  git clone -q "$repo_url" "$down_dir"
  if [[ ! -d "${down_dir}/fns" ]];then
    error "unable to download release from github"
    exit 1
  fi;

  info "Linking" "bashy functions into current profile"
  mkdir -p "${app_dir}/bin" && mv  "${down_dir}"/fns/* "${app_dir}"/bin/

  if [[ $(grep -q -i bashy ~/.bash_aliases && echo "OK") != "OK" ]]; then
    info "Enriching" "bash_aliases with bashy bootstrap"
    cat "${down_dir}"/ahs/bash_aliases.sh >> "${HOME}"/.bash_aliases
  fi

  info "Cleaning" "installation artifacts"
  rm -rf "$down_dir"
}

# base config for project installation
app_dir="$HOME/.bashy"
down_dir="/tmp/bashy_${RANDOM}"
repo_url=https://github.com/realfabecker/bashy.git

# bashy base installation through git clone
bashy_install

# done install
info "Completed" "link installation"