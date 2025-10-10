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

# aliases
source $HOME/.zsh_aliases

eval "$(zoxide init --cmd cd bash)"
