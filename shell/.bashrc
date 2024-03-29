###############################################################################
# bash history                                                                #
###############################################################################
# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

source $HOME/dotfiles/shell/.shellrc
source $HOME/dotfiles/shell/aliases.sh



###############################################################################
# AWS                                                                         #
###############################################################################
complete -C aws_completer aws

###############################################################################
# asdf version manager
###############################################################################
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
  . ~/.asdf/asdf.sh
  . ~/.asdf/completions/asdf.bash
fi

###############################################################################
# Prompt & Git                                                                #
###############################################################################
export GIT_PROMPT_THEME=Dima
# Default - 5mins, change to 3hr (360mins)
export GIT_PROMPT_FETCH_TIMEOUT=180
. ~/dotfiles/shell/bash-git-prompt/gitprompt.sh
. ~/dotfiles/shell/git-completion.bash
