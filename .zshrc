# dir for zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# if there's no zinit, download it
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)" && 
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit light MichaelAquilina/zsh-autoswitch-virtualenv

# load completions
autoload -U compinit && compinit

# Import oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# Load dircolors and set LS_COLORS
if [ -f ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# ENV vars
export EDITOR=nvim

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

# alt + ←→
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# PG up/PG down
bindkey "^[[5~" backward-word
bindkey "^[[6~" forward-word

# home/end
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

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
alias ls='ls --color=auto'
alias la='ls -lha --color=auto'
alias CombineAudio='pactl load-module module-combine-sink'
alias CombineAudioOff='pactl unload-module module-combine-sink'
alias up='$DIR/update.sh'
alias upmesh='$DIR/vpn_off.sh' 
alias upvpn='$DIR/vpn_on.sh' 
alias ssh-list="grep -E '^\s*Host\s+' ~/.ssh/config | awk '{print $2}'"
alias ssh-open='cryfs "$HOME/.local/share/plasma-vault/ssh_keys.enc/" "$HOME/.ssh/ssh_keys"'
alias ssh-close='cryfs-unmount $HOME/.ssh/ssh_keys/'
alias spicetify-update='spicetify restore backup apply'
alias weather='curl wttr.in/:Chelyabinsk'
alias open='xdg-open'
alias browser='$DIR/browser_search'
alias vi='nvim'

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


# load zoxide and fzf
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# ASCII - asciiart.eu
