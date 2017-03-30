#!/bin/bash

git config --global user.email "ci@icctv.gq"
git config --global user.name "iCCTV Continuous Integration"

cd ..

export ANDROID_NDK="${ANDROID_HOME}android-ndk-r10d"

echo "ANDROID_NDK=${ANDROID_NDK}"
ls $ANDROID_NDK

echo "Installed NDK Platforms"
ls $ANDROID_NDK/platforms

echo "Updating libraries..."
./init_update_libs.sh || exit 1

echo "Starting build process..."
./android_build.sh || exit 1

echo "Zipping built binaries..."
zip -r build.zip build
