#!/bin/bash

# init
bash init.sh

URL="https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev"

echo "[INFO] Installing screenfetch ..."
wget --no-check-certificate -O ${INSTALL_PATH}/screenfetch $URL
echo "[INFO] Installing screenfetch DONE!"
