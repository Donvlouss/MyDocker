FROM ubuntu:20.04

RUN apt update && \
    apt install -y curl zsh git vim

RUN bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

RUN zsh && \
    zinit self-update