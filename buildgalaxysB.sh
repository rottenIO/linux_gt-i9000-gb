echo "Using JVS Precompiled modules (I9000B)"
cp usr/prebuilt_ko_JVS.zip usr/prebuilt_ko.zip
./build.sh aries_ltb_talon_defconfig
echo "Restoring JVR Precompiled modules (I9000)"
cp usr/prebuilt_ko_JVR.zip usr/prebuilt_ko.zip