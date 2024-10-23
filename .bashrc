#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTCONTROL=ignoredups
HISTSIZE=2000
HISTFILESIZE=2000

PS1='[\u@\h \W]\$ '
alias ls='ls --color=auto'
alias grep='grep --color=auto'

DIR=$HOME/.dotfiles/scripts

# custom aliases 
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

eval "$(zoxide init --cmd cd bash)"
