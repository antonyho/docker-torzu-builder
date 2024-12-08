FROM ubuntu:latest AS builder

WORKDIR /builder
COPY build.sh .
WORKDIR /torzu
RUN apt-get update && apt-get install -y tor git build-essential torsocks netcat-traditional
RUN apt-get install -y curl zip unzip tar wget autoconf catch2 cmake g++-11 gcc-11 glslang-tools libasound2t64 libavfilter9 libavcodec-dev libavfilter-dev libboost-context-dev libfmt-dev libglu1-mesa-dev libhidapi-dev liblz4-dev libmbedtls-dev libpulse-dev libssl-dev libswscale-dev libtool libudev-dev libva-dev libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xinerama0 libxcb-xkb1 libxext-dev libxkbcommon-x11-0 libxxhash-dev libzstd-dev mesa-common-dev nasm ninja-build nlohmann-json3-dev qtbase5-dev qtbase5-private-dev qtmultimedia5-dev qttools5-dev qtwebengine5-dev libfuse2
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /builder/build.sh


FROM scratch AS export-stage
COPY --from=builder /torzu/output/* /
#ENTRYPOINT [ "ls", "-l" ]