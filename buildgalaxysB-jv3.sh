echo "Using JV3 Precompiled modules (I9000B)"
cp usr/prebuilt_ko_JV3.zip usr/prebuilt_ko.zip
./build-jv3.sh aries_ltb_talon_defconfig
echo "Restoring JVS Precompiled modules (I9000)"
cp usr/prebuilt_ko_JVS.zip usr/prebuilt_ko.zip