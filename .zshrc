# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# dir for zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# if there's no zinit, download it
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname $ZINIT_HOME)" && 
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# add PowerLevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# load completions
autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


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

# ctrl + ←→
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# alt + ←→
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# PG up/PG down
bindkey "^[[5~" backward-word
bindkey "^[[6~" forward-word

# ctrl + backspace
bindkey "^H" backward-kill-word

# home/end
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line


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
alias ls='ls --color=auto'
alias la='ls -lha --color=auto'
alias code='com.visualstudio.code'
alias weather='curl wttr.in/:Chelyabinsk'
alias CombineAudio='pactl load-module module-combine-sink'
alias CombineAudioOff='pactl unload-module module-combine-sink'
alias up='$DIR/update.sh'
alias upmesh='$DIR/vpn_off.sh' 
alias upvpn='$DIR/vpn_on.sh' 
alias Lid-disable='$DIR/lid_disable.sh'
alias Lid-enable='$DIR/lid_enable.sh'
alias b='xdg-open'
alias bs='$DIR/browser_search'
alias spicetify-update='spicetify update && spicetify restore backup apply'
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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


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
