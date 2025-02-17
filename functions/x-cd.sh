#!/bin/bash

x-cd () {
  USAGE=$(cat <<HELP
Usage:
    ${FUNCNAME[0]} [c|dir]

Examples:

   # walks into a directory
   ${FUNCNAME[0]} workspace

Positional:

    c    generates autocomplete
HELP
)

 args=("$@")

 [[ -z "${args[0]}" ]] && echo "$USAGE" && return 1

 if [[ ! -f ~/.fzf/idx.txt ]]; then
   mkdir -p ~/.fzf && touch ~/.fzf/idx.txt
 fi

 if [[ ${args[0]} == 'c' ]]; then
   if [[ ! -z $(cat ~/.fzf/idx.txt) ]]; then
      NMS=$(cat ~/.fzf/idx.txt | xargs -n1 basename | paste -sd ' ') && complete -W "$NMS" x-cd
   fi
   return 0
 fi

 if [[ -d ${args[0]} ]]; then
   d=$(echo ${args[0]} | sed 's/\/$//')

   if [[ -z $(cat ~/.fzf/idx.txt | grep -E $d$) ]]; then
      echo $d >> ~/.fzf/idx.txt
   fi;

   cd $d && x-cd c && return 0
 fi;

 if [[ ! "${args[0]}" =~ "$" ]]; then
    args[0]="/${args[0]}$"
 fi

 cd "$( fzf -1 --height 40% -e -q "${args[*]}" < ~/.fzf/idx.txt)"
}

# gererates completions
x-cd c
