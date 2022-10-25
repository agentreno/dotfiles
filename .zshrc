# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(git kube-ps1)

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

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH=$PATH:/usr/local/go/bin
[ -d ~/go ] || mkdir ~/go
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin

# Autocompletions
source <(kubectl completion zsh)
source <(gh completion -s zsh)

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$(python -m site --user-base)":$PATH

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
export DEFAULT_USER=karl
export PROMPT='$(kube_ps1)'$PROMPT
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/karl/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/karl/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/karl/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/karl/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
