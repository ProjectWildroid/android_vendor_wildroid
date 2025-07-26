#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

$(call enforce-product-packages-exist, \
    android.hardware.health@2.0-impl-default.recovery \
    com.android.ranging \
    DeviceDiagnostics \
    product_manifest.xml \
    uprobestats)
