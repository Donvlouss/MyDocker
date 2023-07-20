FROM ubuntu2004_zsh:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

RUN apt update && \
    apt install -y openjdk-17-jdk unzip

ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64

ARG SDK_FILE=commandlinetools-linux-9477386_latest.zip
ARG ANDROID_HOME=/opt/android
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    wget -P ${ANDROID_HOME} https://dl.google.com/android/repository/${SDK_FILE} && \
    unzip ${ANDROID_HOME}/${SDK_FILE} -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest && \
    rm ${ANDROID_HOME}/${SDK_FILE}

ENV ANDROID_HOME ${ANDROID_HOME}
ARG SDKMANGER=$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH $SDKMANGER:$PATH

RUN echo "TEST"
RUN echo $SDKMANGER/sdkmanager
RUN yes | $SDKMANGER/sdkmanager --licenses && \
    $SDKMANGER/sdkmanager "platform-tools" "platforms;android-31" "ndk;21.3.6528147" "ndk;25.1.8937393" "build-tools;31.0.0" "cmake;3.22.1"
ENV NDK_HOME $ANDROID_HOME/ndk/21.3.6528147
ENV ANDROID_NDK ${NDK_HOME}
ENV PATH $ANDROID_HOME/platform-tools:$PATH

