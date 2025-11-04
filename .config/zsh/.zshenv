export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="librewolf"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export PAGER="less -R --use-color -Dd+r -Du+b"
export LESS='-R --use-color -Dd+r$Du+b'
export VISUAL="nvim"
export VIDEO="vlc"
export OPENER="xdg-open"
export READER="librewolf"
export GTK_USE_PORTAL=1
export EXA_COLORS="di=34:ln=36;3:so=31;1:pi=32:cd=33:bd=33;1;4"
export TERM="xterm-256color"
export LESSHISTFILE=-
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export BORG_REPO=/mnt/ctrlz/SYS

export GTK_THEME=Space-transparency
export QT_QPA_PLATFORMTHEME=qt6ct

