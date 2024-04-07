# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# >>> Aliases >>>

alias uplib='/home/atariaf/Projects/Scripts/update_libraries.sh'

# Set tmux to use tmux.conf at a different location
alias tmux='tmux -f /home/atariaf/.config/tmux/tmux.conf'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/atariaf/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/atariaf/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/atariaf/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/atariaf/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Set the default EDITOR
export EDITOR='nvim'

# Adding .local/bin to system-wide PATH.
export PATH="$HOME/.local/bin:$PATH"

setxkbmap -option ctrl:nocaps

# Adding Libraries folder for Lean development to Python Path.
export PYTHONPATH="/home/atariaf/Projects/lean/Libraries:$PYTHONPATH"

