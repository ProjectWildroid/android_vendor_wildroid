#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_SUPPORTED_DISTROS := \
    lineage \
    miku

LOCAL_DISTROS_TO_ADD := $(filter-out $(WILDROID_MULTIPRODUCT_SKIP_DISTROS),$(LOCAL_SUPPORTED_DISTROS))

ifndef WILDROID_MULTIPRODUCT_AOSP_PRODUCTMK
    $(error Please set WILDROID_MULTIPRODUCT_AOSP_PRODUCTMK to the path of AOSP product makefile)
endif

ifndef WILDROID_MULTIPRODUCT_NAME
    $(error Please set WILDROID_MULTIPRODUCT_NAME to your desired PRODUCT_NAME suffix)
endif

# Supported values: pc, phone, tablet
WILDROID_MULTIPRODUCT_TYPE ?= phone

# Supported values: full, mini
WILDROID_MULTIPRODUCT_SIZE ?= full

WILDROID_MULTIPRODUCT_IS_GO ?= false
WILDROID_MULTIPRODUCT_IS_WIFIONLY ?= false

LOCAL_VARS_SUFFIX_LIST := \
    AOSP_PRODUCTMK \
    TYPE \
    SIZE \
    IS_GO \
    IS_WIFIONLY \
    SKIP_DISTROS \
    NAME # must keep this at last

$(foreach distro,$(LOCAL_DISTROS_TO_ADD),\
    $(eval PRODUCT_MAKEFILES += $(distro)_$(WILDROID_MULTIPRODUCT_NAME):vendor/wildroid/multiproduct/$(distro).mk)\
    $(foreach suffix,$(LOCAL_VARS_SUFFIX_LIST),\
        $(eval WILDROID_MULTIPRODUCT.$(distro)_$(WILDROID_MULTIPRODUCT_NAME).$(suffix) := $(WILDROID_MULTIPRODUCT_$(suffix)))\
        $(eval WILDROID_MULTIPRODUCT_$(suffix) :=)))
