#!/bin/bash

echo "[INFO] Installing git configs ..."

# init
bash init.sh
cd ${DOTPATH}

# install
GIT_CONF="${CONF_DIR}/.gitconfig"
cp ${GIT_CONF} ${HOME}

echo "[INFO] Installing git configs DONE!"

