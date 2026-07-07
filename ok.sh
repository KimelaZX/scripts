#!/bin/bash

# Clean up
rm -rf .repo/local_manifests
rm -rf device/itel/S666LN
rm -rf device/itel/S666LN-kernel
rm -rf device/millennium/common-kernel
rm -rf vendor/itel/S666LN
rm -rf hardware/millennium
rm -rf hardware/mediatek
rm -rf vendor/JamesDSP
rm -rf vendor/mediatek/ims
rm -rf device/mediatek/sepolicy_vndr

# Init Source
repo init --depth=1 -u https://github.com/Lunaris-AOSP/android -b 16.2 --git-lfs
/opt/crave/resync.sh

# Device Specific
git clone https://github.com/KimelaZX/device_itel_S666LN -b lunar device/itel/S666LN
git clone https://github.com/KimelaZX/device_itel_S666LN-kernel -b sixteen device/itel/S666LN-kernel
git clone https://github.com/KimelaZX/android_device_millennium_common-kernel -b sixteen-q2 device/millennium/common-kernel
git clone https://github.com/MillenniumOSS/android_device_mediatek_sepolicy_vndr -b sixteen-qpr2-rebase device/mediatek/sepolicy_vndr
git clone https://github.com/KimelaZX/vendor_itel_S666LN -b lineage-23.2 vendor/itel/S666LN 
git clone https://github.com/KimelaZX/android_hardware_mediatek -b sixteen hardware/mediatek
git clone https://github.com/MillenniumOSS/android_hardware_millennium -b sixteen hardware/millennium
git clone https://github.com/MillenniumOSS/android_vendor_JamesDSP -b sixteen vendor/JamesDSP
git clone https://github.com/MillenniumOSS/android_vendor_mediatek_ims -b sixteen-oem vendor/mediatek/ims
rm -rf package/apps/Aperture
git clone https://github.com/MillenniumOSS/android_packages_apps_Aperture -b lineage-23.2 package/apps/Aperture
rm -rf external/wpa_supplicant_8
git clone https://github.com/KimelaZX/android_external_wpa_supplicant_8 -b lineage-23.2 external/wpa_supplicant_8

export BUILD_USERNAME=KimelaZPrjkt
export BUILD_HOSTNAME=At-Your-Service

# Build
. build/envsetup.sh
lunch lineage_S666LN-bp4a-userdebug
m bacon

# Upload files to gofile
echo "Upload to gofile will be started..."
if [ -f out/target/product/S666LN/*.zip ]; then
  wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
  chmod +x upload.sh ; ./upload.sh out/target/product/S666LN/*202607*.zip
fi
