FROM archlinux:latest as base
RUN pacman -Sy reflector --noconfirm

RUN reflector \
    --country 'RU' \
    --sort rate \
    --latest 20 \
    --fastest 10 \
    --age 12 \
    --save /etc/pacman.d/mirrorlist

ENV GOPATH="/home/vs/.local/share/go"
RUN pacman -Syu --needed --noconfirm base-devel sudo-rs git neovim htop zoxide ripgrep fzf noto-fonts-cjk

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

# install packages
RUN yay -S --noconfirm oh-my-posh


FROM build as final
ENV LANG=C.UTF-8
WORKDIR /home/vs
USER vs
CMD ["/usr/bin/bash"]

