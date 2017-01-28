#!/bin/bash

echo "[INFO] Installing tmux configs ..."

# init
bash init.sh
cd ${DOTPATH}

if type wget > /dev/null 2>&1; then
  GET_CMD="wget"
else
  GET_CMD="curl -O"
fi

# tmux
TMUXRC="${CONF_DIR}/.tmux.conf"
TMUX_BUILD_PATH="${DOTPATH}/tmux_build"

## install tmux
echo "[INFO] Downloading tmux ..."
mkdir ${TMUX_BUILD_PATH}
cd ${TMUX_BUILD_PATH}
$GET_CMD "https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz"
echo "[INFO] Expanding tmux ..."
tar zxf tmux-2.3.tar.gz
cd tmux-2.3

### install libevent
echo "[INFO] Downloading libevent ..."
$GET_CMD "https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz"
echo "[INFO] Expanding libevent..."
tar zxf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable

echo "[INFO] Configuring libevent ..."
mkdir "${INSTALL_PATH}/libevent"
./configure --prefix="${INSTALL_PATH}/libevent"
echo "[INFO] Installing libevent ..."
make
make install
echo "[INFO] Installing libevent DONE!"

cd "${TMUX_BUILD_PATH}/tmux-2.3"

echo "[INFO] Configuring tmux ..."
PKG_CONFIG_PATH="${INSTALL_PATH}/libevent/lib/pkgconfig" ./configure --prefix=${INSTALL_PATH}
echo "[INFO] Installing tmux ..."
make
make install
echo "[INFO] Installing tmux DONE!"

rm -rf ${TMUX_BUILD_PATH}

## tmux conf
cp ${TMUXRC} ${HOME}

echo "[INFO] Installing tmux configs DONE!"
