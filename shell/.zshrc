# Share some of the same setup with bash
source $HOME/dotfiles/shell/.shellrc
source $HOME/dotfiles/shell/aliases.sh

######################################################################
# ohmyzsh config taken from the template:
# https://github.com/ohmyzsh/ohmyzsh/blob/dac3314c76e799cddbbe5cf63870d31861626059/templates/zshrc.zsh-template
######################################################################

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Candidates: kphoen, refined, re5et
ZSH_THEME="random"

plugins=(
    git
    aws
    themes # adds theme and lstheme functions
    timer # show executino time of every command unobtrusively
    urltools # urlencode/urldecode
    vi-mode
    web-search
)

# plugin: vi-mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh
