#!/bin/bash

echo -e "Initialization started\n"

pushd ~/edk2
rm MikanLoaderPkg || true
ln -s $OS_DIR/MikanLoaderPkg ./
source edksetup.sh
cp /workspaces/mikanos-devcontainer/target.txt Conf/target.txt
source ~/osbook/devenv/buildenv.sh
alias mikan='(cd $OS_DIR/kernel; export OPTMCONF="-O2"; make; cd /workspaces/mikanos-devcontainer; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
alias dmikan='(cd $OS_DIR/kernel; export OPTMCONF="-O0"; make; cd /workspaces/mikanos-devcontainer; export QEMU_OPTS="-s -S"; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
alias mikanb='(cd $OS_DIR/kernel; export OPTMCONF="-O2"; make clean; make -B; cd /workspaces/mikanos-devcontainer; rm disk.img; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
alias dmikanb='(cd $OS_DIR/kernel; export OPTMCONF="-O0"; make -B; cd /workspaces/mikanos-devcontainer; export QEMU_OPTS="-s -S"; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
alias gdbmikan='gdb -x /workspaces/mikanos-devcontainer/debug_mikan'
echo -e "\nSuccessfully initialized"
popd