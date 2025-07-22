#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, vendor/wildroid/config/common.mk)

ifeq ($(WILDROID_DISTRIBUTION_NAME),AOSP)

$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/wildroid/overlay/tablet

# Settings
PRODUCT_PRODUCT_PROPERTIES += \
    persist.settings.large_screen_opt.enabled=true

endif
