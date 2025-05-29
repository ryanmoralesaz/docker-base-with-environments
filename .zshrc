# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Use modern completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# Note: dircolors might not be available in minimal Docker images
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Environment variables
export EDITOR=vim

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Development shortcuts adapted for Docker environments
alias workspace='cd /workspace'

# Function to show environment-specific info
function show_dev_info() {
    echo "${fg_bold[cyan]}==================================================${reset_color}"
    echo "${fg_bold[green]}Docker Development Environment Ready!${reset_color}"
    echo "${fg_bold[cyan]}==================================================${reset_color}"

    # Check which environment we're in
    if command -v java >/dev/null 2>&1; then
        echo "${fg_bold[yellow]}Java Environment Detected${reset_color}"
        echo "  ${fg_bold[white]}Java Version:${reset_color} $(java -version 2>&1 | head -n 1)"
        echo "  ${fg_bold[white]}Maven:${reset_color} $(mvn -version 2>&1 | head -n 1 | cut -d' ' -f3)"
        echo ""
        echo "${fg_bold[yellow]}Quick Commands:${reset_color}"
        echo "  ${fg_bold[white]}javac MyClass.java${reset_color} - Compile Java file"
        echo "  ${fg_bold[white]}java MyClass${reset_color}       - Run Java class"
        echo "  ${fg_bold[white]}mvn init${reset_color}           - Initialize Maven project"
    fi

    if command -v zig >/dev/null 2>&1; then
        echo "${fg_bold[yellow]}Zig Environment Detected${reset_color}"
        echo "  ${fg_bold[white]}Zig Version:${reset_color} $(zig version)"
        echo ""
        echo "${fg_bold[yellow]}Quick Commands:${reset_color}"
        echo "  ${fg_bold[white]}zig init-exe${reset_color}    - Create executable project"
        echo "  ${fg_bold[white]}zig init-lib${reset_color}    - Create library project"
        echo "  ${fg_bold[white]}zig build${reset_color}       - Build project"
        echo "  ${fg_bold[white]}zig test${reset_color}        - Run tests"
    fi

    echo ""
    echo "${fg_bold[yellow]}Common Commands:${reset_color}"
    echo "  ${fg_bold[white]}workspace${reset_color}       - Go to /workspace directory"
    echo "  ${fg_bold[white]}tmux${reset_color}            - Start tmux session"
    echo "  ${fg_bold[white]}vim${reset_color}             - Start vim with plugins"
    echo "${fg_bold[cyan]}==================================================${reset_color}"
}

# Show info on startup
show_dev_info