# NVIDIA Tegra TK1 "Yellowstone" development system
#
# Copyright (c) 2016 NVIDIA Corporation.  All rights reserved.
#
# Copyright (C) 2019 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Built in opengapps nano

GAPPS_VARIANT := nano

# Yellowstone has a custom patched webview for egl sync erros DO NOT build WebViewGoogle
GAPPS_EXCLUDED_PACKAGES := \
	WebViewGoogle \
        PlusOne

$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)

PRODUCT_AAPT_CONFIG += xlarge large
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1200

$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

TARGET_TEGRA_VERSION := t124

## Common product locale
PRODUCT_LOCALES += en_US

# Project Tango Boot Animation
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bootanimation.zip:system/media/bootanimation.zip

# Set up device overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/gpsconfig.xml:system/etc/gps/gpsconfig.xml \
    $(LOCAL_PATH)/gps/rootcert.pem:system/etc/gps/rootcert.pem \
    $(LOCAL_PATH)/gps/gps.conf:system/etc/gps.conf

# LTE APNS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/apns-conf.xml:system/etc/apns-conf.xml

# NVCAMERA HAL CONF
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nvcamera.conf:system/etc/nvcamera.conf

# camera permission file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml


#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0

# OPENGL AEP permission file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

# NVIDIA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.nvidia.feature.xml:system/etc/permissions/com.nvidia.feature.xml

# Bluetooth
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    $(LOCAL_PATH)/bluetooth/BCM43341B0_002.001.014.0122.0135.hcd:system/etc/firmware/BCM43341B0_002.001.014.0122.0135.hcd


# Codec Configs
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml

# Busybox utils
PRODUCT_PACKAGES += \
    busybox

# wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

# bcmdhd/mrvl wifi_loader.sh
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/wifi_loader.sh:system/bin/wifi_loader.sh

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)

LOCAL_FSTAB := $(LOCAL_PATH)/rootdir/etc/fstab.ardbeg
TARGET_RECOVERY_FSTAB = $(LOCAL_FSTAB)

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.ardbeg \
    init.ardbeg.rc \
    init.comms.rc \
    init.hdcp.rc \
    init.icera.common.rc \
    init.icera.rc \
    init.icera.tablet.rc \
    init.nv_dev_board.usb.rc \
    init.recovery.nv_dev_board.usb.rc \
    init.t124_emmc.rc \
    init.t124.rc \
    init.tlk.rc \
    ueventd.ardbeg.rc

TARGET_RECOVERY_DEVICE_MODULES := rm-wrapper

## REFERENCE_DEVICE
REFERENCE_DEVICE := ardbeg


PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    com.android.location.provider

RRODUCT_PACKAGES += \
    Chrome \
    setup_fs \
    e2fsck \
    drmserver \
    libdrmframework_jni

# Filesystem management tools
PRODUCT_PACKAGES += \
    setup_fs

# Radio Interface
PRODUCT_PACKAGES += rild

ENABLE_WIDEVINE_DRM := true
ifeq ($(ENABLE_WIDEVINE_DRM),true)
#enable Widevine DRM
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm \
    libwvdrmengine \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1
endif

TARGET_POWERHAL_VARIANT := tegra

# vendor HALs
PRODUCT_PACKAGES += \
    power.tegra \
    lights.tegra

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/nvaudio_fx.xml:system/etc/nvaudio_fx.xml \
    $(LOCAL_PATH)/audio/nvaudio_conf.xml:system/etc/nvaudio_conf.xml

PRODUCT_PACKAGES += \
    audio.primary.tegra \
    audio.a2dp.default \
    audio.usb.default \
    camera.tegra \
    audio.r_submix.default \
    libaudio-resampler \
    libaudiospdif \
    libtinyalsa \
    libtinycompress \
    tinycap \
    tinymix \
    tinyplay \
    xaplay \
    libstagefrighthw \
    enctune.conf

# NVIDIA hardware support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ussrd.conf:system/etc/ussrd.conf \
    $(LOCAL_PATH)/set_hwui_params.sh:system/bin/set_hwui_params.sh \
    $(LOCAL_PATH)/set_light_sensor_perm.sh:system/bin/set_light_sensor_perm.sh \
    $(LOCAL_PATH)/input_cfboost_init.sh:system/bin/input_cfboost_init.sh \
    $(LOCAL_PATH)/ussr_setup.sh:system/bin/ussr_setup.sh \
    $(LOCAL_PATH)/power.ardbeg.rc:system/etc/power.ardbeg.rc \
    $(LOCAL_PATH)/nvcms/device.cfg:system/lib/nvcms/device.cfg \
    $(LOCAL_PATH)/graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml \
    $(LOCAL_PATH)/graphics/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml \
    $(LOCAL_PATH)/graphics/com.nvidia.nvsi.xml:system/etc/permissions/com.nvidia.nvsi.xml

PRODUCT_PACKAGES += \
    lbh_images

# Input configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/raydium_ts.idc:system/usr/idc/raydium_ts.idc


WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# we have enough storage space to hold precise GC data
#PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tablet

# Call the proprietary setup
$(call inherit-product, vendor/google/yellowstone/yellowstone-vendor.mk)
$(call inherit-product, vendor/google/widevine/widevine.mk)


