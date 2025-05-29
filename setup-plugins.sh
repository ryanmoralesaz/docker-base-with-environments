#!/bin/bash
# setup-plugins.sh - Run this inside the container to set up plugins

echo "Setting up Vim plugins..."

# Create a basic .vimrc if it doesn't exist
if [ ! -f ~/.vimrc ]; then
    cat > ~/.vimrc << 'EOF'
" Basic Vim configuration with vim-plug
call plug#begin('~/.vim/plugged')

" Add your favorite plugins here
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'ziglang/zig.vim'

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Basic settings
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
syntax enable
colorscheme gruvbox
set background=dark

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>
EOF
fi

# Install Vim plugins
echo "Installing Vim plugins..."
vim +PlugInstall +qall

echo "Setting up Tmux plugins..."

# Create a basic .tmux.conf if it doesn't exist
if [ ! -f ~/.tmux.conf ]; then
    cat > ~/.tmux.conf << 'EOF'
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @plugin 'christoomey/vim-tmux-navigator'

# Enable mouse mode
set -g mouse on

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF
fi

# Install Tmux plugins
echo "Installing Tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "Setup complete! Restart tmux for changes to take effect."