# base.Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Use fast mirror
RUN sed -i 's|http://archive.ubuntu.com|http://mirrors.kernel.org|g' /etc/apt/sources.list && \
    sed -i 's|http://security.ubuntu.com|http://mirrors.kernel.org|g' /etc/apt/sources.list

# Install dependencies first
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Add Vim PPA and install latest vim-gtk3
RUN add-apt-repository ppa:jonathonf/vim -y && \
    apt-get update && \
    apt-get install -y vim-gtk3 || apt-get install -y vim

# Install remaining tools
RUN apt-get update && apt-get install -y \
    tmux \
    build-essential \
    xz-utils \
    zsh \
    xclip \
    ripgrep \
    fzf \
    && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy config files
COPY .vimrc /root/.vimrc
COPY .tmux.conf /root/.tmux.conf
COPY .zshrc* /root/
RUN if [ -f /root/.zshrc.docker ]; then mv /root/.zshrc.docker /root/.zshrc; fi

# Create a temporary vimrc that skips vim-go for plugin installation
RUN cp ~/.vimrc ~/.vimrc.backup && \
    sed -i "/vim-polyglot/s/^/\" Temporarily disabled: /" ~/.vimrc && \
    vim -E -s -u ~/.vimrc +PlugInstall +qall || true && \
    mv ~/.vimrc.backup ~/.vimrc

# Alternative: Install plugins with error suppression
# RUN vim +'silent! PlugInstall' +qall 2>/dev/null || true

# Install tmux plugins
RUN ~/.tmux/plugins/tpm/bin/install_plugins || true

# Set zsh as default shell
ENV SHELL=/bin/zsh

# Set up working directory
WORKDIR /workspace

CMD ["zsh"]