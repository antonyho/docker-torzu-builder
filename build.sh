#!/bin/bash


tor &
echo "Starting Tor..."
while ! nc -z localhost 9050; do echo "Waiting for Tor to start..."; sleep 1; done
echo "Tor is running."

mkdir /src && cd /src
git -c http.proxy=socks5h://127.0.0.1:9050 clone --depth 1 http://vub63vv26q6v27xzv2dtcd25xumubshogm67yrpaz2rculqxs7jlfqad.onion/torzu-emu/torzu.git
cd /src/torzu
git submodule update --init --recursive
mkdir /src/torzu/build && cd /src/torzu/build
cmake .. -GNinja -DYUZU_USE_BUNDLED_VCPKG=ON -DYUZU_TESTS=OFF -DCMAKE_C_COMPILER=gcc-11 -DCMAKE_CXX_COMPILER=g++-11 -DYUZU_USE_QT_WEB_ENGINE=ON
ninja
cd /src/torzu
export APPIMAGE_EXTRACT_AND_RUN=1
./AppImage-build.sh

mkdir /torzu/output
cp -r /src/torzu/build/bin /torzu/output/
cp /src/torzu/*.AppImage /torzu/output/

echo "Complete."