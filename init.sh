#!/bin/bash

export DOTPATH="${HOME}/.dotfiles"
export INSTALL_PATH="${HOME}/.local/bin"
export CONF_DIR="${DOTPATH}/config"

# make dotpath dir
if [ ! -e ${DOTPATH} ]; then
  git clone "https://raw.githubusercontent.com/peinan/.dotfiles-server/master/install.sh" "${DOTPATH}"
fi

# make install path dir
if [ ! -e ${INSTALL_PATH} ]; then
  mkdir -p ${INSTALL_PATH}
fi
