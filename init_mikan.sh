#!/bin/bash

echo -e "Initialization started\n"

pushd ~/edk2
rm MikanLoaderPkg || true
ln -s $OS_DIR/MikanLoaderPkg ./
source edksetup.sh
cp /workspaces/mikanos-devcontainer/target.txt Conf/target.txt
source ~/osbook/devenv/buildenv.sh
echo -e "\nSuccessfully initialized"
popd