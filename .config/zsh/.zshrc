# XDG base dir fallback
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"

[[ -f "$XDG_CONFIG_HOME/zsh/zsh_aliases" ]] && source "$XDG_CONFIG_HOME/zsh/zsh_aliases"

# Use XDG dirs for completion and history files
[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000; SAVEHIST=10000

setopt sharehistory hist_ignore_all_dups hist_save_no_dups hist_find_no_dups hist_ignore_space

[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# dir for zinit and plugins
ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
# if there's no zinit, download it
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load zinit + plugins FIRST
source "${ZINIT_HOME}/zinit.zsh"
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-autoswitch-virtualenv
zinit light zsh-users/zsh-syntax-highlighting

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Import oh-my-posh
eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/config.toml")"

# ENV vars
export EDITOR=nvim
export GPG_TTY=$(tty)
export PODMAN_COMPOSE_WARNING_LOGS=false
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export FLUTTER_ROOT="$XDG_DATA_HOME/flutter"
export PUB_CACHE="$XDG_CACHE_HOME/pub"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export ANDROID_SDK_ROOT="$XDG_DATA_HOME/android"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export GOPATH="$XDG_DATA_HOME/go"

export ANSIBLE_HOME="$XDG_DATA_HOME/ansible"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="$XDG_CACHE_HOME/ansible/galaxy_cache"

export FZF_CTRL_R_OPTS="--bind 'ctrl-j:ignore,ctrl-k:ignore,alt-j:down,alt-k:up'"

######################################################################################
#  ___  ___  ________  _________  ___  __    _______       ___    ___ ________       #
# |\  \|\  \|\   __  \|\___   ___\\  \|\  \ |\  ___ \     |\  \  /  /|\   ____\      #
# \ \  \\\  \ \  \|\  \|___ \  \_\ \  \/  /|\ \   __/|    \ \  \/  / | \  \___|_     #
#  \ \   __  \ \  \\\  \   \ \  \ \ \   ___  \ \  \_|/__   \ \    / / \ \_____  \    #
#   \ \  \ \  \ \  \\\  \   \ \  \ \ \  \\ \  \ \  \_|\ \   \/  /  /   \|____|\  \   #
#    \ \__\ \__\ \_______\   \ \__\ \ \__\\ \__\ \_______\__/  / /       ____\_\  \  #
#     \|__|\|__|\|_______|    \|__|  \|__| \|__|\|_______|\___/ /       |\_________\ #
#                                                        \|___|/        \|_________| #
######################################################################################

# emacs mode
bindkey -e

# exceptions for backward-kill-word
# removes [/ . $ - = " #] from $WORDCHARS
WORDCHARS=${WORDCHARS//[\/\.\$\-\=\"\#]}

# home/end
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# PG up/PG down
bindkey "^[[5~" backward-word
bindkey "^[[6~" forward-word

# alt + ←→
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# alt + hl
bindkey '^[h' backward-char
bindkey '^[l' forward-char

# alt + jk
bindkey '^[j' down-history
bindkey '^[k' up-history

# alt + ctrl + HL
bindkey '^[^H' backward-word
bindkey '^[^L' forward-word

# alt+del forward delete word
bindkey '^[[3;3~' kill-word

# del forward char 
bindkey '^[[3~' delete-char

# unbind beginning-of-line
bindkey -r '^A'

#########################################################################
#  ________  _________    ___    ___ ___       _______   ________       #
# |\   ____\|\___   ___\ |\  \  /  /|\  \     |\  ___ \ |\   ____\      #
# \ \  \___|\|___ \  \_| \ \  \/  / | \  \    \ \   __/|\ \  \___|_     #
#  \ \_____  \   \ \  \   \ \    / / \ \  \    \ \  \_|/_\ \_____  \    #
#   \|____|\  \   \ \  \   \/  /  /   \ \  \____\ \  \_|\ \|____|\  \   #
#     ____\_\  \   \ \__\__/  / /      \ \_______\ \_______\____\_\  \  #
#    |\_________\   \|__|\___/ /        \|_______|\|_______|\_________\ #
#    \|_________|       \|___|/                            \|_________| #
#########################################################################

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' format '%F{blue}%B%d%b%f'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(zoxide init --cmd cd zsh)"
eval "$(pay-respects zsh)"
eval "$(fzf --zsh)"

# blinking beam
echo -ne '\e[6 q'
precmd() { echo -ne '\e[6 q' }

# ASCII - asciiart.eu
