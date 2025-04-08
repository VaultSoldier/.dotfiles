FROM archlinux:latest as base
RUN pacman -Sy reflector --noconfirm

RUN reflector \
  --country 'RU' \
  --protocol https \
  --sort rate \
  --latest 20 \
  --fastest 10 \
  --age 12 \
  --save /etc/pacman.d/mirrorlist

ENV GOPATH="/home/vs/.local/share/go"
RUN pacman -Syu --needed --noconfirm base-devel sudo unzip go github-cli man-db tealdeer \ 
tmux git git-zsh-completion neovim ripgrep zoxide fzf stow tmux npm imagemagick zsh

FROM base as user
RUN useradd -m vs && \
    echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel && \
    usermod -aG wheel vs

RUN pacman -Syu --needed --noconfirm wl-clipboard btop

USER vs
WORKDIR /home/vs
FROM user as build

RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
    cd /tmp/yay && \
    makepkg -si --noconfirm && \
    rm -rf /tmp/yay

RUN yay -S --noconfirm oh-my-posh

# Zsh setup
RUN sh -c "$(curl -fsSL https://git.io/zinit-install)" && \
    echo 'source ~/.zshrc' >> ~/.zshenv

# Dotfiles
RUN git clone https://github.com/VaultSoldier/.dotfiles.git ~/.dotfiles && \
    cd ~/.dotfiles && \
    rm /home/vs/.bashrc && \
    rm /home/vs/.zshrc && \
    stow .

RUN zsh -c 'zinit self-update' && \
    zsh -c 'zinit light zsh-users/zsh-syntax-highlighting' && \
    zsh -c 'zinit light zsh-users/zsh-autosuggestions' && \
    zsh -c 'zinit light MichaelAquilina/zsh-autoswitch-virtualenv'

RUN nvim --headless "+Lazy! sync" +qa && \
    nvim --headless -c 'MasonToolsInstallSync' -c 'quitall'

RUN tldr -u && history -c

from build as final
ENV LANG=C.UTF-8
WORKDIR /home/vs
USER root
RUN "chsh -s $(which zsh)"
USER vs
CMD ["/usr/bin/zsh"]

