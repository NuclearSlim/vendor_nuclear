PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/nuclear/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/nuclear/prebuilt/common/bin/50-nuclear.sh:system/addon.d/50-nuclear.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# SLIM-specific init file
PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/etc/init.local.rc:root/init.slim.rc

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/nuclear/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/nuclear/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/nuclear/prebuilt/common/bin/sysinit:system/bin/sysinit

# Required packages
PRODUCT_PACKAGES += \
    Development \
    SpareParts \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    SlimLauncher \
    LatinIME \
    BluetoothExt

#    SlimFileManager removed until updated

## Slim Framework
include frameworks/opt/slim/slim_framework.mk

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/nuclear/overlay/common \
    vendor/nuclear/overlay/dictionaries

# Boot animation include
PRODUCT_COPY_FILES += \
    vendor/nuclear/prebuilt/common/bootanimation/1080.zip:system/media/bootanimation.zip

# Versioning System
# Nuclear first version.
ROM_VERSION = 6.0.1
ROM_VERSION_STATUS = OFFICIAL
ROM_VERSION_MAINTENANCE = $(VER_ROM)
ROM_POSTFIX := $(shell date +"%Y%m%d-%H%M")

NUCLEAR_VERSION := NucleaRom-V$(ROM_VERSION_MAINTENANCE)-$(ROM_VERSION_STATUS)[$(ROM_VERSION)]-$(DEVICEVERSION)-$(ROM_POSTFIX)
NUCLEAR_MOD_VERSION := NucleaRom-V$(ROM_VERSION_MAINTENANCE)-$(ROM_VERSION_STATUS)[$(ROM_VERSION)]-$(DEVICEVERSION)-$(ROM_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.nuclear.version=$(NUCLEAR_VERSION) \
    ro.modversion=$(NUCLEAR_MOD_VERSION) \
    ro.nuclear.buildtype=$(ROM_VERSION_STATUS)

EXTENDED_POST_PROCESS_PROPS := vendor/nuclear/tools/nuclear_process_props.py

