###############################################################################
# bash history                                                                #
###############################################################################
# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

###############################################################################
# bash aliases                                                                #
###############################################################################
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -al'

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias s='git status'

alias f='fg'
alias tf='terraform'
alias tfw='terraform workspace'

##### Ruby
alias b='bundle exec'


##### Docker
alias d='docker'
alias dc='docker-compose'
alias dr='docker run --rm -it'
alias docker-rma='docker rm -f $(docker ps -a -q)'
alias docker-rmia='docker rmi $(docker images -q)'

alias docker-stop-all='docker stop $(docker ps -q)'
alias docker-clean-images="docker images -a > /tmp/docker-images-cleanup && vim /tmp/docker-images-cleanup && cat /tmp/docker-images-cleanup | docker rmi -f \$(awk 'NR!=1{print $3}')"
alias docker-stats-short='docker stats --format "table {{.Name}} {{.Container}}\t{{.CPUPerc}}\t{{.MemPerc}}"'



###############################################################################
# Defaults for the apps                                                       #
###############################################################################
export PSQL_EDITOR=vim
export GPG_TTY=$(tty)
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

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
. ~/dotfiles/bash/bash-git-prompt/gitprompt.sh
. ~/dotfiles/bash/git-completion.bash


###############################################################################
# Everything else...                                                          #
###############################################################################
