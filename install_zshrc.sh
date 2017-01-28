#!/bin/bash

echo "[INFO] Installing zsh configs ..."

# init
bash init.sh
cd ${DOTPATH}

# install
cp ${CONF_DIR}/.zshrc ${HOME}
## alias
## TODO: とりあえず全部コピってるけど、ゆくゆくはプロファイル選択できるようにしたい
cp ${CONF_DIR}/.alias.* ${HOME}

echo "[INFO] Installing zsh configs DONE!"

