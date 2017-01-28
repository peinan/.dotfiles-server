#!/bin/bash

# init

## path setting
export DOTPATH="${HOME}/.dotfiles"
export INSTALL_PATH="${HOME}/.local/bin"
export CONF_DIR="${DOTPATH}/config"

## make dotpath dir
if [ ! -e ${DOTPATH} ]; then
  git clone "https://github.com/peinan/.dotfiles-server.git" "${DOTPATH}"
fi

## make install path dir
if [ ! -e ${INSTALL_PATH} ]; then
  mkdir -p ${INSTALL_PATH}
fi

# install items
cd ${DOTPATH}
## zsh
bash install_zshrc.sh
## vim
bash install_vim.sh
## git
bash install_git.sh
## tmux
bash install_tmux.sh
## pyenv
bash install_pyenv.sh
## icdiff
bash instsall_icdiff.sh
## screenfetch
bash install_screenfetch.sh

echo "[INFO] Installing ALL configs DONE!"

cat smile

exec $SHELL -l
