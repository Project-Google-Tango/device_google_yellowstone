# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit device configuration
$(call inherit-product, device/google/yellowstone/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := yellowstone
PRODUCT_DEVICE := yellowstone
PRODUCT_BRAND := google
PRODUCT_MODEL := Yellowstone
PRODUCT_MANUFACTURER := Google

## ST8 Kernel
KERNEL_PATH=$(CURDIR)/kernel-shieldtablet8

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=google/tango/yellowstone:4.4.2/KOT49H.161129/161129002:user/release-keys \
    PRODUCT_NAME=tango \
    PRIVATE_BUILD_DESC="ardbeg-user 4.4.2 KOT49H.161129 161129002 release-keys"

## including rild here to create modem for data only skus without dialer and
## mms apps , not including generic.mk
PRODUCT_PACKAGES += rild

## enable Wifi Access Point monitor (needed for two-step SAR backoff)
PRODUCT_PACKAGES += icera-config

PRODUCT_PROPERTY_OVERRIDES += \
    ro.modem.do=1 \
    ril.icera-config-args=notifier:ON,datastall:ON,lwaactivate

