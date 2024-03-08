#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# custom aliases 
alias ll='ls -lh --color=auto'
alias weather='curl wttr.in/:Chelyabinsk' 
alias up='yay && echo Pacman/aur updated > /dev/pts/0 && flatpak update && plasma-discover-update 2>/dev/null && echo -e "\nDiscover packages updated!" && echo Flatpacks/Discover updated > /dev/pts/0' 
alias upmesh='tailscale up --operator=$USER --accept-routes --accept-dns --reset && echo "VPN DISABLED" > /dev/pts/0' 
alias upvpn='tailscale up --operator=$USER --accept-routes --exit-node-allow-lan-access --accept-dns --exit-node=100.85.223.148 --reset && echo "VPN ENABLED" > /dev/pts/0' 
alias Lid-disable='sed -i "s/lidAction=1/lidAction=64/g" ~/.config/powermanagementprofilesrc' && sed -i "/^\[Battery\]\[SuspendSession\]/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^\[AC\]\[SuspendSession\]/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^\[LowBattery\]\[SuspendSession\]/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^idleTime=900000/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^idleTime=600000/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^idleTime=480000/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^suspendThenHibernate=false/ s/^/#/" ~/.config/powermanagementprofilesrc &&  sed -i "/^suspendType=1/ s/^/#/" ~/.config/powermanagementprofilesrc && sed -i "/^suspendThenHibernate=true/ s/^/#/" ~/.config/powermanagementprofilesrc
alias Lid-enable='sed -i "s/lidAction=64/lidAction=1/g" ~/.config/powermanagementprofilesrc' 
alias CombineAudio='pactl load-module module-combine-sink'
alias CombineAudioOff='pactl unload-module module-combine-sink'

eval "$(zoxide init --cmd cd bash)"
