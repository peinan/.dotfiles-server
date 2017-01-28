#!/bin/bash

echo "[INFO] Installing pyenv ..."

# init
bash init.sh

# pyenv
cd ${HOME}
git clone "https://github.com/yyuu/pyenv.git" "${HOME}/.pyenv"

source "${HOME}/.zshrc"

echo "[INFO] Installing pyenv DONE!"
