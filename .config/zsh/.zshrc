#PROMPT='[%F{green}%n@%m%f:%F{magenta}%~%f]$ '
#PROMPT='%F{green}[%n@%m%f%F{blue}:%~%F{green}]$%f '
PROMPT='%F{green}[%n@%m%f%F{blue}:%~%F{green}]%F{white}$%f '
RPROMPT='%F{blue}[%D{%H:%M:%S}]%f'

[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
 [[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

HISTFILE="$XDG_STATE_HOME"/zsh/history

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

[[ -s /home/relja/.autojump/etc/profile.d/autojump.sh ]] && source /home/relja/.autojump/etc/profile.d/autojump.sh

autoload -Uz compinit
autoload -Uz select-word-style
select-word-style bash

if [[ -n $ZSH_COMPDUMP && -f $ZSH_COMPDUMP ]]; then
    compinit -C
    compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
else
    compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
fi

SAVEHIST=10000
HISTSIZE=10000
WORDCHARS=${WORDCHARS/\/}
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'

setopt inc_append_history
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt globdots
setopt complete_aliases
setopt auto_cd
setopt SHARE_HISTORY
unsetopt correct

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' glob 1
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 4
zstyle ':completion:*' menu select=3
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1

zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%U%F{yellow}%B%d%b%f%u' 
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'  
zstyle ':completion::complete:*' use-cache 1

alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"
alias runmc='java -jar spigot-1.21.4.jar nogui'
alias grep="grep --color=auto"
alias cp="cp -iv"
alias rm="rm -vI"
alias ffmpeg="ffmpeg -hide_banner"
alias nano='nano -wl'
alias ls='eza --icons --group-directories-first --git'
alias lsls='lsd --classify -lSh --timesort'
alias diff="diff --color=auto" 
alias cat='bat --color=auto'
alias vim='nvim'
alias ip='ip --color=auto'
alias c="xclip"
alias v="xclip -o"
alias cs="xclip -in"
alias vs="xclip -o -sel clip"
alias pac="sudo pacman"
alias diff="diff --color=auto"
alias reload="source ~/.config/zsh/.zshrc && echo 'Zsh config reloaded!'"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias i2c='java -cp "lib/*:lib/i2p.jar" net.i2p.router.Router'
alias qp='LC_ALL=C.UTF-8 pacman -Qi | awk "/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}" | LC_ALL=C.UTF-8 sort -h'
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

alias aiolcd='liquidctl -m nzxt set lcd screen gif'
alias aiopump='liquidctl -m nzxt set pump speed'
alias aiofan='liquidctl -m nzxt set fan speed'

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
source /home/relja/.config/zsh-alias/.zsh_aliases

eval "$(starship init zsh)"
# Prompt Engineering Starship
PROMPT_NEEDS_NEWLINE=false

precmd() {
  if [[ "$PROMPT_NEEDS_NEWLINE" == true ]]; then
    echo
  fi
  PROMPT_NEEDS_NEWLINE=true
}

clear() {
  PROMPT_NEEDS_NEWLINE=false
  command clear
}
