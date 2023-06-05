#!/bin/bash

echo -e "Initialization started\n"

pushd ~/edk2
rm MikanLoaderPkg || true
ln -s $OS_DIR/MikanLoaderPkg ./
source edksetup.sh
if [ $(uname -p) == "aarch64" ]; then
	EDKTOOLS="$HOME/edk2/Conf/tools_def.txt"
  sed -i s/^'DEFINE CLANG38_X64_TARGET'.*/'DEFINE CLANG38_X64_TARGET           = -target x86_64-linux-gnu'/ ${EDKTOOLS}
  sed -i s/^'DEBUG_CLANG38_X64_CC_FLAGS'.*/'DEBUG_CLANG38_X64_CC_FLAGS         = DEF(CLANG38_ALL_CC_FLAGS) -m64 "-DEFIAPI=__attribute__((ms_abi))" -mno-red-zone -mcmodel=small -fpie -Oz -flto DEF(CLANG38_X64_TARGET) -g -I\/usr\/x86_64-linux-gnu\/include'/ ${EDKTOOLS}
fi
cp /workspaces/mikanos-devcontainer/target.txt Conf/target.txt
source ~/osbook/devenv/buildenv.sh
# until 18a
# alias mikan='(cd $OS_DIR/kernel; export OPTMCONF="-O2"; make; cd /workspaces/mikanos-devcontainer; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
# alias dmikan='(cd $OS_DIR/kernel; export OPTMCONF="-O0"; make; cd /workspaces/mikanos-devcontainer; export QEMU_OPTS="-s -S"; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
# alias mikanb='(cd $OS_DIR/kernel; export OPTMCONF="-O2"; make clean; make -B; cd /workspaces/mikanos-devcontainer; rm disk.img; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
# alias dmikanb='(cd $OS_DIR/kernel; export OPTMCONF="-O0"; make -B; cd /workspaces/mikanos-devcontainer; export QEMU_OPTS="-s -S"; ~/osbook/devenv/run_qemu.sh ~/edk2/Build/MikanLoaderX64/DEBUG_CLANG38/X64/Loader.efi $OS_DIR/kernel/kernel.elf)'
# alias gdbmikan='gdb -x /workspaces/mikanos-devcontainer/debug_mikan'

# from 18b
alias mikan='(export OPTMCONF="-O2"; cd $OS_DIR; APPS_DIR=apps ./build.sh run)'
alias mikanb='(export OPTMCONF="-O2"; export MAKE_OPTS="-B"; cd /workspaces/mikanos-devcontainer; rm disk.img; cd $OS_DIR/kernel; make clean; cd $OS_DIR/; APPS_DIR=apps ./build.sh run)'

# set global gitignore file
IGNOREFILE="${HOME}/.gitignore_global"
cat <<EOF > ${IGNOREFILE}
c_cpp_properties.json
settings.json
EOF
git config --global core.excludesFile ${IGNOREFILE}

# install gdb
sudo apt update
sudo apt install gdb

echo -e "\nSuccessfully initialized"
popd
