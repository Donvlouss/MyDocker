FROM ubuntu:20.04

RUN apt update && \
    apt install software-properties-common && \
    apt update

# Install packags
RUN apt install -y sudo vim tmux curl git htop

# Install zsh oh-my-zsh
