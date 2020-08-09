# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(git zsh-completions kube-ps1)

source $ZSH/oh-my-zsh.sh

# Aliases
alias xclip='xclip -selection c'

# Helper functions
function git-pull-develop() {
   #get current branch
   export BRANCH="$(git rev-parse --abbrev-ref HEAD)"

   echo "Switching to develop"
   git checkout develop
   
   echo "Pulling from origin"
   git pull

   echo "Switching back to branch $BRANCH"
   git checkout $BRANCH
}

# Credentials if they exist
source ~/.credentials.sh 2> /dev/null
source ~/dotfiles/workdotfiles/credentials.sh 2> /dev/null

# Work dotfiles if they exist 
source ~/dotfiles/workdotfiles/scripts.sh 2> /dev/null

# Environment variables
export AWS_PROFILE=personal

export NVM_DIR="/home/karl/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="/home/karl/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=$PATH:/usr/local/go/bin
[ -d ~/go ] || mkdir ~/go
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin

# Autocompletions
source <(awless completion zsh)
source <(kubectl completion zsh)
autoload -U compinit && compinit

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$(python -m site --user-base)":$PATH
eval "$(pipenv --completion)"

function refresh-container() {
   if [[ -z "$1" ]]; then
      echo "Need a docker-compose service name"
   else
     docker-compose stop $1
     docker-compose rm -f $1
     docker-compose build $1
     docker-compose create $1
     docker-compose start $1
     docker-compose logs -f $1
   fi
}

alias dkc='docker-compose'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

function decode() {
    echo $1 | base64 --decode
}

alias kc='kubectl'
alias ci='circleci'

alias grepdir='grep --exclude-dir={'.mypy_cache','.pytest_cache'} -nR'

complete -C "$(which aws_completer)" aws
export ANDROID_SDK=/home/karl/Android/Sdk
export PATH=$ANDROID_SDK/platform-tools:$PATH
export DEFAULT_USER=karl
export PROMPT='$(kube_ps1)'$PROMPT
