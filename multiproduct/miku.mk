#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

include $(WILDROID_MULTIPRODUCT_AOSP_PRODUCTMK)

MIKU_MASTER ?= $(WILDROID_BUILD_ID)

LOCAL_MIKU_PRODUCT_MK_FILENAME := miku_product

ifeq ($(WILDROID_MULTIPRODUCT_TYPE),pc)
LOCAL_MIKU_PRODUCT_MK_FILENAME += _tab
else ifeq ($(WILDROID_MULTIPRODUCT_TYPE),tablet)
LOCAL_MIKU_PRODUCT_MK_FILENAME += _tab
else
LOCAL_MIKU_PRODUCT_MK_FILENAME += _phone
endif

LOCAL_MIKU_PRODUCT_MK_FILENAME += .mk

LOCAL_MIKU_PRODUCT_MK_FILENAME := $(subst $(space),,$(LOCAL_MIKU_PRODUCT_MK_FILENAME))

$(call inherit-product, vendor/miku/build/product/$(LOCAL_MIKU_PRODUCT_MK_FILENAME))

PRODUCT_NAME := miku_$(WILDROID_MULTIPRODUCT_NAME)

$(call enforce-product-packages-exist,product_manifest.xml rild Calendar Launcher3 Launcher3Go Launcher3QuickStep Launcher3QuickStepGo android.hidl.memory@1.0-impl.vendor vndk_apex_snapshot_package)
