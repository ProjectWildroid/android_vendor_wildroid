#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_VARS_SUFFIX_LIST := \
    AOSP_PRODUCTMK \
    NAME \
    TYPE \
    SIZE \
    IS_GO \
    IS_WIFIONLY

$(foreach suffix,$(LOCAL_VARS_SUFFIX_LIST),\
    $(eval WILDROID_MULTIPRODUCT_$(suffix) := $(WILDROID_MULTIPRODUCT.$(TARGET_PRODUCT).$(suffix))))

include $(WILDROID_MULTIPRODUCT_AOSP_PRODUCTMK)

TARGET_UNOFFICIAL_BUILD_ID ?= $(WILDROID_BUILD_ID)

LOCAL_LINEAGE_PRODUCT_MK_FILENAME := common

ifeq ($(WILDROID_MULTIPRODUCT_SIZE),mini)
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _mini
else
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _full
endif

ifeq ($(WILDROID_MULTIPRODUCT_IS_GO),true)
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _go
endif

ifeq ($(WILDROID_MULTIPRODUCT_TYPE),pc)
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _tablet
else ifeq ($(WILDROID_MULTIPRODUCT_TYPE),tablet)
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _tablet
else
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _phone
endif

ifeq ($(WILDROID_MULTIPRODUCT_IS_WIFIONLY),true)
LOCAL_LINEAGE_PRODUCT_MK_FILENAME += _wifionly
endif

LOCAL_LINEAGE_PRODUCT_MK_FILENAME += .mk

LOCAL_LINEAGE_PRODUCT_MK_FILENAME := $(subst $(space),,$(LOCAL_LINEAGE_PRODUCT_MK_FILENAME))

$(call inherit-product, vendor/lineage/config/$(LOCAL_LINEAGE_PRODUCT_MK_FILENAME))

PRODUCT_NAME := lineage_$(WILDROID_MULTIPRODUCT_NAME)

$(call enforce-product-packages-exist,product_manifest.xml rild Calendar android.hidl.memory@1.0-impl.vendor vndk_apex_snapshot_package)
