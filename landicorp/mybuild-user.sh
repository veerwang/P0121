#!/bin/bash
if [ -z $JBUILD ]; then
    JBUILD=$(cat /proc/cpuinfo |grep processor |wc -l)
fi

##---uboot
cd u-boot
make clean
make mrproper
./make.sh ld-px30 | tee ../build-uboot.log

##---kernel
cd ../kernel
make ARCH=arm64 ld_px30_defconfig
make ARCH=arm64 px30-ld.img -j$JBUILD 2>&1 | tee ../build-kernel.log

##---android
cd ..
source build/envsetup.sh
lunch px30_ld-user

vendor/build/scripts/build-px30_ld_ota.sh user all
unset JBUILD
