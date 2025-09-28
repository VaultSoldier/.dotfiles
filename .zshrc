# load completions
autoload -Uz compinit && compinit

# dir for zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# if there's no zinit, download it
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

# Import oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# Load dircolors and set LS_COLORS
if [ -f ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# ENV vars
export PODMAN_COMPOSE_WARNING_LOGS=false
export EDITOR=nvim
export GOPATH="$HOME/.local/share/go"
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
# removes [/ . $ -] from $WORDCHARS
WORDCHARS=${WORDCHARS//[\/\.\$\-\=\"]}

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

# alt + ctrl + jk
bindkey '^[^H' backward-word
bindkey '^[^L' forward-word

# alt+del forward delete word
bindkey '^[[3;3~' kill-word

# del forward char 
bindkey '^[[3~' delete-char

# unbind beginning-of-line
bindkey -r '^A'

##########################################################################
#  ________  ___       ___  ________  ________  _______   ________       #
# |\   __  \|\  \     |\  \|\   __  \|\   ____\|\  ___ \ |\   ____\      #
# \ \  \|\  \ \  \    \ \  \ \  \|\  \ \  \___|\ \   __/|\ \  \___|_     #
#  \ \   __  \ \  \    \ \  \ \   __  \ \_____  \ \  \_|/_\ \_____  \    #
#   \ \  \ \  \ \  \____\ \  \ \  \ \  \|____|\  \ \  \_|\ \|____|\  \   #
#    \ \__\ \__\ \_______\ \__\ \__\ \__\____\_\  \ \_______\____\_\  \  #
#     \|__|\|__|\|_______|\|__|\|__|\|__|\_________\|_______|\_________\ #
#                                       \|_________|        \|_________| #
##########################################################################

DIR=$HOME/.dotfiles/scripts

alias t='tmux'
alias g='git'
alias gs='git status'
alias ls='ls --color=auto'
alias la='ls -lha --color=auto'
alias docker-compose='docker compose'
alias CombineAudio='pactl load-module module-combine-sink'
alias CombineAudioOff='pactl unload-module module-combine-sink'
alias up="$DIR/update.sh"
alias upmesh="$DIR/vpn_mesh.sh"
alias uphome="$DIR/vpn_home.sh"
alias upvpn="$DIR/vpn_on.sh"
alias ssh-list="rg '^\s*Host\s+' ~/.ssh/config | awk '{print $2}'"
alias ssh-work-list="rg '^\s*Host\s+' ~/.ssh/ssh_keys/work/config | awk '{print $2}'"
alias ssh-open='cryfs "$HOME/.local/share/plasma-vault/ssh_keys.enc/" "$HOME/.ssh/ssh_keys"'
alias ssh-close='cryfs-unmount $HOME/.ssh/ssh_keys/'
alias weather='curl wttr.in/:Челябинск'
alias open='xdg-open'
alias vi='nvim'
alias hx='helix'
alias arch='docker run --rm -it vaultsoldier/arch-dotfiles:latest'

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

zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "=(#b)${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu-select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' format '%F{blue}%B%d%b%f'

# history
HISTSIZE=3000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# ASCII - asciiart.eu
