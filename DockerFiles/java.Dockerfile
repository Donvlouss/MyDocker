FROM ubuntu2004_zsh:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

RUN apt update && \
    apt install -y openjdk-17-jdk

RUN echo "export JAVA_HOME=/ust/lib/jvm/java-17-openjdk-amd64" >> ~/.zshrc && \
    echo "export PATH=\$JAVA_HOME:\$PATH" >> ~/.zshrc
