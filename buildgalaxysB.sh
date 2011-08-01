echo "Using JV3 Precompiled modules (I9000B)"
cp usr/prebuilt_ko_JV3.zip usr/prebuilt_ko.zip
./build.sh aries_ltb_talon_defconfig
echo "Restoring JVQ Precompiled modules (I9000)"
cp usr/prebuilt_ko_JVQ.zip usr/prebuilt_ko.zip