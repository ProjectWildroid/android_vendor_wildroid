#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

ifeq ($(WILDROID_DISTRIBUTION_NAME),AOSP)

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/wildroid/overlay/tablet

endif
