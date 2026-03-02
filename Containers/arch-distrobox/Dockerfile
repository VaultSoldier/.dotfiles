FROM archlinux:latest as base

ENV GOPATH="/home/vs/.local/share/go"
RUN pacman -Syu --needed --noconfirm base-devel sudo-rs git neovim htop zoxide ripgrep fzf noto-fonts-cjk wl-clipboard

FROM base as user
RUN useradd -m vs && \
    echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel && \
    usermod -aG wheel vs

FROM user as build
RUN pacman -Sy --needed --noconfirm python
# Flutter dependencies
RUN pacman -Sy --needed --noconfirm gcc gtk3 clang cmake ninja mesa-utils android-tools

USER vs
WORKDIR /tmp/yay
RUN git clone https://aur.archlinux.org/yay.git . && \
    makepkg -si --noconfirm && \
    rm -rf /tmp/yay

RUN yay -S --noconfirm oh-my-posh

USER root
RUN userdel vs

FROM build as final
ENV LANG=C.UTF-8
