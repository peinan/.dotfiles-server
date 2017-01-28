#!/bin/bash

echo "[INFO] Installing vim configs ..."

# init
bash init.sh
cd ${DOTPATH}

# install
VIMRC="${CONF_DIR}/.vimrc"
## install NeoBundle
echo "[INFO] Installing NeoBundle ..."
curl "https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh" | sh
echo "[INFO] Installing NeoBundle DONE!"
## vimrc
cp ${VIMRC} ${HOME}

echo "[INFO] Installing vim configs DONE!"
