#!/bin/bash

sudo apt-get --quiet --yes install \
  build-essential \
  git \
  autoconf \
  libtool \
  pkg-config \
  gperf \
  gettext \
  python-lxml \
  libgd2-xpm \
  ia32-libs \
  ia32-libs-multiarch \
  p7zip \
  checkinstall \
  rpl >/dev/null

sudo apt-get build-dep yasm
wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz >/dev/null
tar -xf yasm-1.2.0.tar.gz >/dev/null
cd yasm-1.2.0 || exit 1
./configure >/dev/null
make >/dev/null
sudo checkinstall --pakdir "$HOME" --pkgname yasm --pkgversion 1.2.0 --backup=no --default >/dev/null
cd - || exit 1


echo "$ANDROID_HOME"

cd $ANDROID_HOME || exit 1

wget --timeout=120 http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86.bin -O ndk.bin >/dev/null
md5sum ndk.bin | grep 70ed6d8c34e7e620c145b791e8eeef89
7zr x ndk.bin >/dev/null

export ANDROID_NDK="${ANDROID_HOME}android-ndk-r10d"

cd - || exit 1

export ADB_INSTALL_TIMEOUT=5

mkdir "$ANDROID_HOME/licenses" || true
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

echo y | android update sdk -u -a -t tools >/dev/null
echo y | android update sdk -u -a -t platform-tools >/dev/null
echo y | android update sdk -u -a -t build-tools-$ANDROID_BUILD_TOOLS >/dev/null
echo y | android update sdk -u -a -t android-$ANDROID_API >/dev/null
echo y | android update sdk -u -a -t cmake >/dev/null
echo y | android update sdk -u -a -t lldb >/dev/null
echo y | android update sdk -u -a -t extra-google-m2repository >/dev/null
echo y | android update sdk -u -a -t extra-android-m2repository >/dev/null
