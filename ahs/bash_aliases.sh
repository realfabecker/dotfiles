# bashy: pre export for function config
export PATH=$PATH:$HOME/.bashy/bin

# gnome: keeps only leaf directory name
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# x-cd: autocomplete directory list
x-cd c

# x-git-init-gpg: autocomplete gpg names
x-git-init-gpg c