# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(git vagrant autoenv)

source $ZSH/oh-my-zsh.sh

# Aliases
alias git=hub
alias xclip='xclip -selection c'

# Helper functions
function git-pull-master() {
   #get current branch
   export BRANCH="$(git rev-parse --abbrev-ref HEAD)"

   echo "Switching to master"
   git checkout master
   
   echo "Fetching from origin"
   git fetch

   echo "Pulling from origin"
   git pull

   echo "Switching back to branch $BRANCH"
   git checkout $BRANCH
}

function git-delete-branch() {
   if [[ -z "$1" ]]; then
      echo "Need a branch ID"
   else
      git branch -D $1
      git push origin --delete $1
   fi
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
# awless
source <(awless completion zsh)
source <(kubectl completion zsh)

# hub
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$(python -m site --user-base)":$PATH
