# base.Dockerfile
FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install common tools for both environments
RUN apt-get update && apt-get install -y \
    vim-gtk3 \
    tmux \
    git \
    curl \
    wget \
    build-essential \
    xz-utils \
    zsh \
    xclip \
    && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install vim-plug for Vim plugin management
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Set zsh as default shell
ENV SHELL=/bin/zsh

# Set up working directory
WORKDIR /workspace