#!/bin/bash

echo "[INFO] Installing icdiff ..."

# init
bash init.sh
cd ${DOTPATH}

# icdiff
URL="github.com/jeffkaufman/icdiff/archive/release-1.8.1.tar.gz"
BUILD_PATH="${DOTPATH}/icdiff_build"
mkdir ${BUILD_PATH}
cd ${BUILD_PATH}
if type wget > /dev/null 2>&1; then
  CMD_GET="wget"
else
  CMD_GET="curl -O"
fi
## install
${CMD_GET} ${URL}
tar zxf release-1.8.1.tar.gz
cp icdiff-release-1.8.1/{icdiff,git-icdiff} ${INSTALL_PATH}/bin
rm -rf ${BUILD_PATH}

echo "[INFO] Installing icdiff DONE!"
