# enable passphrase prompt for gpg
export GPG_TTY=$(tty)

if [ -d "$HOME/.bash_functions" ]; then
   for f in ~/.bash_functions/*.sh; do
    if [[ -f "$f" ]]; then
       source "$f"
    fi
   done
fi
