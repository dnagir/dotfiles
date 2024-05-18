# Share some of the same setup with bash
source $HOME/dotfiles/shell/.shellrc
source $HOME/dotfiles/shell/aliases.sh

######################################################################
# ohmyzsh config taken from the template:
# https://github.com/ohmyzsh/ohmyzsh/blob/dac3314c76e799cddbbe5cf63870d31861626059/templates/zshrc.zsh-template
######################################################################

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="refined"

plugins=(
    git
    aws
    themes # adds theme and lstheme functions
    vi-mode
)

# plugin: vi-mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh


# Increase the size of history file.
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
