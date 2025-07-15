#
# SPDX-FileCopyrightText: The Wildroid Project
# SPDX-License-Identifier: Apache-2.0
#

WILDROID_TOP=$(gettop)

function wildroid_apply_patches() {
    local PATCHES_ROOT_DIR=${WILDROID_TOP}/wildroid/patches/${WILDROID_DISTRIBUTION}

    if [ -z "$WILDROID_DISTRIBUTION" ] || [ ! -d "$PATCHES_ROOT_DIR" ]; then
        echo "Error: Missing patches directory for distribution $WILDROID_DISTRIBUTION"
        return
    fi

    rm -f wildroid_apply_patches-failed.txt

    local PATCHES_SUBDIRS=$(dirname $(find $PATCHES_ROOT_DIR -type f -name '*.patch') | sort -u | sed "s|^${PATCHES_ROOT_DIR}/||g")
    while IFS= read -r dir; do
        if ! cd $dir; then
            echo "Error: Failed to enter directory $dir"
            continue
        fi

        local PATCHES_DIR=$PATCHES_ROOT_DIR/$dir
        if ! git am $PATCHES_DIR/*.patch 2>/dev/null >/dev/null; then
            git am --abort
            echo "Error: Failed to apply patches from $PATCHES_DIR for directory $dir"
            cd $WILDROID_TOP
            echo $dir >> wildroid_apply_patches-failed.txt
            continue
        fi

        echo "Info: Applied patches for directory $dir"
        cd $WILDROID_TOP
    done <<< "$PATCHES_SUBDIRS"

    if [ ! -f "wildroid_apply_patches-failed.txt" ]; then
        rm -f wildroid-patches-not-yet-applied.txt
    fi
}

function wildroid_identify_distribution() {
    if [ -d "vendor/lineage" ]; then
        if [ -f "vendor/lineage/release/release_configs/bp2a.textproto" ]; then
            export WILDROID_DISTRIBUTION="LineageOS-23.0"
            export WILDROID_DISTRIBUTION_NAME="LineageOS"
            export WILDROID_DISTRIBUTION_VERSION_MAJOR="23"
            export WILDROID_DISTRIBUTION_VERSION_MINOR="0"
            export WILDROID_ANDROID_VERSION="16"
            export WILDROID_ANDROID_QPR="0"
            return 0
        elif [ -f "vendor/lineage/release/release_configs/bp1a.textproto" ]; then
            export WILDROID_DISTRIBUTION="LineageOS-22.2"
            export WILDROID_DISTRIBUTION_NAME="LineageOS"
            export WILDROID_DISTRIBUTION_VERSION_MAJOR="22"
            export WILDROID_DISTRIBUTION_VERSION_MINOR="2"
            export WILDROID_ANDROID_VERSION="15"
            export WILDROID_ANDROID_QPR="2"
            return 0
        fi
    else
        if [ -f "build/release/release_configs/bp2a.textproto" ]; then
            export WILDROID_DISTRIBUTION="AOSP-16"
            export WILDROID_DISTRIBUTION_NAME="AOSP"
            export WILDROID_ANDROID_VERSION="16"
            export WILDROID_ANDROID_QPR="0"
            return 0
        elif [ -f "build/release/release_configs/bp1a.textproto" ]; then
            export WILDROID_DISTRIBUTION="AOSP-15-QPR2"
            export WILDROID_DISTRIBUTION_NAME="AOSP"
            export WILDROID_ANDROID_VERSION="15"
            export WILDROID_ANDROID_QPR="2"
            return 0
        fi
    fi

    echo "Error: Failed to identify distribution. Wildroid stuff will not behave properly."
    return 1
}

wildroid_identify_distribution

if [ -f "wildroid-patches-not-yet-applied.txt" ]; then
    echo "Wildroid patches are not yet applied. Please run \`wildroid_apply_patches\` to do so."
fi
