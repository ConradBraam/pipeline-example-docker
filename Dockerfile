# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:16.04
# FROM 853142832404.dkr.ecr.eu-west-1.amazonaws.com/jenkins-build-image:latest # enable when/if using compile in docker

# ------------------------------------------------------------------------------
# Arguments
ARG WORKDIR=/work
COPY raas-pyclient/ /work/raas-pyclient/
COPY mbed-clitest/ /work/mbed-clitest/
COPY opentmi_mbed_build_uploader/ /work/opentmi_mbed_build_uploader/
COPY mbed-os-tools/ /work/mbed-os-tools/

# ===================
# temp
COPY ble-cliapp-public/ /work/ble-cliapp/
COPY mbed-os-example-ble/ /work/mbed-os-example-ble/

# ------------------------------------------------------------------------------
# Labels
LABEL version="0.1"

# ------------------------------------------------------------------------------
# Install base
RUN apt-get -y update && apt-get -y dist-upgrade

# ------------------------------------------------------------------------------
# Install tools
RUN apt-get -y install git \
    apt-utils \
    curl \
    libcurl4-openssl-dev \
    python \
    python-dev \
    python-setuptools \
    python-usb \
    python-pip \
    software-properties-common \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/

# ------------------------------------------------------------------------------
# Install arm-none-eabi-gcc
WORKDIR /work/

RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2  && \
    tar -xjf gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2 && \
    rm gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2

ENV PATH="/work/gcc-arm-none-eabi-6-2017-q1-update/bin:${PATH}"

# ------------------------------------------------------------------------------
# Install npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# ------------------------------------------------------------------------------
# Install Python modules
RUN pip install -U \
    futures \
    jsonmerge \
    lxml \
    pydash \
    mbed-cli \
    yattag \
    websocket && pip install -U websocket-client==0.37.0 && pip install -U colorama==0.3.9

WORKDIR /work/mbed-clitest/
RUN python setup.py install

WORKDIR /work/raas-pyclient/
RUN python setup.py install

WORKDIR /work/mbed-os-tools/packages/mbed-greentea/
RUN python setup.py install

WORKDIR /work/mbed-os-tools/packages/mbed-host-tests/
RUN python setup.py install

WORKDIR /work/opentmi_mbed_build_uploader/
RUN python setup.py install

WORKDIR /work/

#RUN pip install -U colorama==0.3.9

# Environment
ENV HOME=$WORKDIR

# ------------------------------------------------------------------------------
# Add Jenkins user
RUN groupadd -g 1001 jenkins && \
    useradd -m -u 1001 -g 1001 -k /home/jenkins jenkins -p jenkins -s /bin/bash -G sudo && \
    chown -R 1001:1001 /work

USER jenkins
