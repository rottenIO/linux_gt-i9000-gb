# Script to build for the captivate and zip the package.
# Written by Evan alias ytt3r
# modified by kodos96 and rottenIO

if ! [ -e .config ]; then
 make $1
fi

ROTTENREL=`cat release.txt`
let ROTTENREL+=1
echo $ROTTENREL > release.txt

# Linaro Android 4.5 (GCC 4.5.4) toolchain - http://www.linaro.org
export CROSS_COMPILE="/opt/toolchains/android-toolchain-eabi-4.5/bin/arm-eabi-"

export KBUILD_BUILD_VERSION="0.5.1-talonB-b$ROTTENREL"

#export LOCALVERSION="-I9000XWJVB-CL118186"
#export LOCALVERSION="-I9000XWJVH-CL184813"
#export LOCALVERSION="-I9000XXJVP-CL264642"
#export LOCALVERSION="-I9000XXJVQ-CL281085"
#export LOCALVERSION="-I9000XXJVR-CL425308"
#latin modules version
export LOCALVERSION="-I9000BVJJV3-CL262510"
#export LOCALVERSION="-I9000XXJVS-CL565837" 

export INSTALL_MOD_PATH=./mod_inst
make modules -j`grep 'processor' /proc/cpuinfo | wc -l`
make modules_install

if [ -e ./usr/initrd_files/lib/modules ]; then
 rm -rf ./usr/initrd_files/lib/modules
fi

mkdir ./usr/initrd_files/lib/modules

for i in `find mod_inst -name "*.ko"`; do
 cp $i ./usr/initrd_files/lib/modules/
done

rm -rf ./mod_inst
unzip ./usr/prebuilt_ko.zip -d ./usr/initrd_files/lib/modules/

cd drivers/misc/samsung_modemctl
make
cd ../../..

make -j`grep 'processor' /proc/cpuinfo | wc -l`
cp arch/arm/boot/zImage releasetools
cd releasetools
rm -f *.zip *.md5
zip -r Talon-`echo $KBUILD_BUILD_VERSION`.zip *
#build odin/heimdall release
tar -H ustar -c zImage > Talon-`echo $KBUILD_BUILD_VERSION`.tar
md5sum -t Talon-`echo $KBUILD_BUILD_VERSION`.tar >> Talon-`echo $KBUILD_BUILD_VERSION`.tar
mv Talon-`echo $KBUILD_BUILD_VERSION`.tar Talon-`echo $KBUILD_BUILD_VERSION`.tar.md5
cd ..
echo "Finished."
