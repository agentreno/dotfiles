# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(git vagrant)

source $ZSH/oh-my-zsh.sh

# Aliases
alias git=hub

# Helper functions
function git-pull-master() {
   #get current branch
   export BRANCH="$(git rev-parse --abrev-ref HEAD)"

   echo "Switching to master"
   git checkout master
   
   echo "Fetching from origin"
   git fetch

   echo "Pulling from origin"
   git pull

   echo "Switching back to branch $BRANCH"
   git checkout $BRANCH
}

