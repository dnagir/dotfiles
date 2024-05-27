alias la='ls -A'
alias ll='ls -al'

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias s='git status'

alias f='fg'
alias tf='terraform'
alias tfw='terraform workspace'
alias n='nvim'

##### Ruby
alias b='bundle exec'


##### Docker
alias d='docker'
alias dc='docker compose'
alias dr='docker run --rm -it'
alias docker-rma='docker rm -f $(docker ps -a -q)'
alias docker-rmia='docker rmi $(docker images -q)'

alias docker-stop-all='docker stop $(docker ps -q)'
alias docker-clean-images="docker images -a > /tmp/docker-images-cleanup && vim /tmp/docker-images-cleanup && cat /tmp/docker-images-cleanup | docker rmi -f \$(awk 'NR!=1{print $3}')"
alias docker-stats-short='docker stats --format "table {{.Name}} {{.Container}}\t{{.CPUPerc}}\t{{.MemPerc}}"'

##### Misc

alias awscurl='curl --aws-sigv4 "aws:amz:${AWS_REGION}:execute-api" --user "${AWS_ACCESS_KEY_ID}:${AWS_SECRET_ACCESS_KEY}" --header "x-amz-security-token:${AWS_SESSION_TOKEN}"'
