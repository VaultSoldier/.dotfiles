FROM archlinux:latest as base

RUN pacman -Syu --needed --noconfirm base-devel sudo-rs git neovim htop \
    zoxide ripgrep fzf noto-fonts-cjk wl-clipboard && \
    pacman -Scc --noconfirm

FROM base as user
RUN useradd -m vs && \
    echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel && \
    usermod -aG wheel vs

ENV GOPATH="/home/vs/.local/share/go"

FROM user as build
ARG NVIM="tree-sitter-cli npm fd"
ARG PYTHON="python uv"
ARG DEVOPS="ansible terraform"
ARG FLUTTER="gcc gtk3 clang cmake ninja mesa-utils android-tools"

RUN pacman -Syu --needed --noconfirm ${NVIM} ${PYTHON} ${FLUTTER} ${DEVOPS} && \
    pacman -Scc --noconfirm

USER vs
WORKDIR /tmp/yay
RUN git clone https://aur.archlinux.org/yay.git . && \
    makepkg -si --noconfirm && \
    rm -rf /tmp/yay && \
    yay -S --noconfirm oh-my-posh

USER root
RUN userdel vs

ENV LANG=C.UTF-8
FROM build as final
