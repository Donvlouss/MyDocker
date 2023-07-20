FROM android-studio

# Initialize python
RUN apt update && \
    apt install -y python3.9 python3-pip && \
    ln -sf /usr/bin/python3.9 /usr/bin/python3 && \
    pip3 install --upgrade pip && \
    pip3 install pyyaml typing_extensions
ENV PYTHON /usr/bin/python3.9

# Intall cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.5/cmake-3.26.5-linux-x86_64.sh && \
    chmod +x cmake-3.26.5-linux-x86_64.sh && \
    mkdir -p /usr/bin/cmake && \
    /cmake-3.26.5-linux-x86_64.sh --skip-license --prefix=/usr/bin/cmake && \
    rm cmake-3.26.5-linux-x86_64.sh

ENV PATH="/usr/bin/cmake/bin:${PATH}"

# Clone Pytorch
RUN mkdir -p /opt/pytorch && \
    cd /opt/pytorch && \
    git clone -b v2.0.0 --depth 1 https://github.com/pytorch/pytorch.git

# Initialize submodule and build
RUN cd /opt/pytorch/pytorch && \
    git submodule sync && \
    git submodule update --init --recursive && \
    sed -i 's/DBUILD_SHARED_LIBS=OFF/DBUILD_SHARED_LIBS=ON/' scripts/build_android.sh 

# Create shared_only script, just remove gradle build section at scripts/build_pytorch_android.sh
RUN echo '#!/bin/bash \n \
        PYTORCH_DIR="$(cd $(dirname $0)/..; pwd -P)" \n \
        PYTORCH_ANDROID_DIR="$PYTORCH_DIR/android" \n \
        echo "PYTORCH_DIR:$PYTORCH_DIR" \n \
        source "$PYTORCH_ANDROID_DIR/common.sh" \n \
        check_android_sdk \n \
        check_gradle \n \
        parse_abis_list "$@" \n \
        build_android' > /opt/pytorch/pytorch/scripts/build_pytorch_android_shared_only.sh && \
    chmod +x /opt/pytorch/pytorch/scripts/build_pytorch_android_shared_only.sh

# Install 3 target plaforms
RUN cd /opt/pytorch/pytorch && \
    bash ./scripts/build_pytorch_android_shared_only.sh armeabi-v7a

RUN cd /opt/pytorch/pytorch && \
    bash ./scripts/build_pytorch_android_shared_only.sh arm64-v8a

RUN cd /opt/pytorch/pytorch && \
    bash ./scripts/build_pytorch_android_shared_only.sh x86_64