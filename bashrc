. ~/dotfiles/bash/env
. ~/dotfiles/bash/config
. ~/dotfiles/bash/aliases

. ~/dotfiles/bash/git-completion

# git-prompt - as external git repo - https://github.com/lvv/git-prompt
[[ $- == *i* ]]   &&   . ~/dotfiles/bash/git-prompt.sh


[[ -s "~/.rvm/scripts/rvm" ]] && source "~/.rvm/scripts/rvm"  # This loads RVM into a shell session.
