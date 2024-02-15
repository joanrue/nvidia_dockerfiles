FROM nvidia/cuda:11.2.2-devel-ubuntu20.04 #
SHELL ["/bin/bash", "-c"]

### Clean image with system tools
ENV DEBIAN_FRONTEND=noninteractive
RUN    apt update \
    && apt install --yes --no-install-recommends apt-file \
                                                 bash-completion \
                                                 build-essential \
                                                 ca-certificates \
                                                 clang \
                                                 python3 \
                                                 tmux \
                                                 wget \
    && rm -rf /var/lib/apt/lists/*

### Install additional programs in ~/tools
WORKDIR /root
RUN    mkdir ~/tools \
    && cd ~/tools \
    # [INSTALL] starship ======================================================
    && wget https://starship.rs/install.sh \
    && sh ./install.sh --yes \
    && rm ./install.sh \
    # [INSTALL] lsd ===========================================================
    && wget https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-v1.0.0-x86_64-unknown-linux-gnu.tar.gz \
    && tar -xzf ./lsd-v1.0.0-x86_64-unknown-linux-gnu.tar.gz \
    && mv ./lsd-v1.0.0-x86_64-unknown-linux-gnu/lsd ./lsd \
    && rm -rf ./lsd-v1.0.0-x86_64-unknown-linux-gnu* \
    # [INSTALL] conda =========================================================
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && sh ./Miniconda3-latest-Linux-x86_64.sh -b -s -p ~/tools/miniconda3 \
    && rm ./Miniconda3-latest-Linux-x86_64.sh

### Configure all tools installed
WORKDIR /root
COPY config/.bashrc        .bashrc
COPY config/.bash_aliases  .bash_aliases
COPY config/.condarc       .condarc
COPY config/.gitconfig     .gitconfig
COPY config/starship.toml  .config/starship.toml

### Keep container running. (Reason: interactive use.)
CMD ["tail", "-f", "/dev/null"]
