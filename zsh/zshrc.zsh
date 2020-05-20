export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=1
export JOBS=max
export EDITOR='code'
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export GEM_HOME=$HOME/gems
export GOPATH=$HOME/go
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/gems/bin:$GOPATH/bin:$PATH
export TERM="xterm-256color"
# load oh-my-zsh

ZSH_THEME="cloud"

## ALIASSES

### DOCKER
alias d='docker'
alias dc='docker-compose'
alias dim='docker images'
alias dprune="d system prune"
alias dprune!="d system prune --force"
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drm='docker rm -f'

### GIT
alias g="git"
alias got="git"
alias gti="git" # no volkswagen ;)
alias gott="git"
alias gitt="git"

alias gs="git status"
alias gf="git-flow"
alias ginit='git init'
alias gb='git branch'
alias gc='git commit'

### KUBERNETES
alias k='kubectl'
alias kgx='kubectl config get-contexts'
alias ksx='kubectl config set-context'
alias kdx='kubectl config delete-context'
alias kns='kubectl config set-context --current --namespace'
alias kex='kubectl exec -it'
alias kani='kubectl auth can-i'

### TERRAFORM
alias t='terraform'

### SYSTEM ALIASSES
alias c="clear"
alias ec="$EDITOR $HOME/dotfiles"
alias sc="source $HOME/.zshrc"
alias hosts='sudo $EDITOR /etc/hosts'

alias dev="cd $HOME/workspace"
alias customers="cd $HOME/workspace/customers"
alias private="cd $HOME/workspace/private"
alias public="cd $HOME/workspace/public"
alias customres="customers" # I do this type often

# macOS aliasses
if [[ $OSTYPE == darwin* ]]; then
alias flush='dscacheutil -flushcache'
# Apps
alias slack="open -a /Applications/Slack.app"
alias tower="open -a /Applications/Tower.app"
alias browse="open -a /Applications/Google\ Chrome.app"
# * Browse Azure Portal
alias azure="browse https://preview.portal.azure.com"
# * Browse O365 Portal
alias office="browse https://portal.office.com"
# * Docker Hub
alias dhub="browse https://hub.docker.com"

fi

source $ZSH/lib/git.zsh
source $ZSH/lib/key-bindings.zsh
source $ZSH/plugins/kubectl
source $ZSH/plugins/minikube
source $ZSH/plugins/docker
source $ZSH/plugins/helm
source $ZSH/plugins/terraform
source $ZSH/lib/history.zsh
source $ZSH/lib/completion.zsh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'

#nvm
export NVM_DIR=${HOME}/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


autoload bashcompinit && bashcompinit

LANG="en_US.UTF-8"
export LC_ALL=en_US.UTF-8

#load prompt
source ${HOME}/dotfiles/zsh/prompt.zsh


source $ZSH/oh-my-zsh.sh