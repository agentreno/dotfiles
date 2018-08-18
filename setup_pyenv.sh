#!/bin/bash

USER=${1:-`whoami`}

export PATH="/home/$USER/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv install 3.7.0
pyenv install 2.7.15
pyenv virtualenv 2.7.15 python2-tools
pyenv virtualenv 3.7.0 python3-tools
pyenv global 3.7.0 python3-tools python2-tools

pyenv activate python2-tools
pip install flake8
pip install ipython
pyenv deactivate

pyenv activate python3-tools
pip install flake8
pip install ipython
pip install httpie
pyenv deactivate
