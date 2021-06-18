#!/bin/bash

set -e

echo -e "Initialization started\n"

cd ~/edk2
rm MikanLoaderPkg
ln -s $OS_DIR/MikanLoaderPkg ./
source edksetup.sh
cp /workspaces/mikanos-devcontainer/target.txt Conf/target.txt
echo -e "\nSuccessfully initialized"