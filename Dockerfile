FROM debian:stretch

RUN 	DEBIAN_FRONTENT=noninteractive apt-get update && \
	apt-get install -y \
		qtbase5-dev \
		qtbase5-dev-tools \
		qttools5-dev-tools \
		qtscript-tools \
		python-all-dev \
		build-essential \
		qt5-default \
		bison \
		flex \
		qtbase5-private-dev \
		qtconnectivity5-dev \
		qtdeclarative5-dev \
		qtdeclarative5-dev-tools \
		qtconnectivity5-dev \
		qt5keychain-dev \
		qt5-style-plugins \
		tcl8.6-dev \
		tk8.6-dev \
		tcl \
		libgsl-dev \
		libreadline-dev \
		python3 \
		mercurial \
		iverilog \
		git \
		gawk \
		cmake \
		clang \
		pkg-config \
		libkf5texteditor-dev \
		gettext \
		libqt5svg5-dev \
		qttools5-dev \
		qtmultimedia5-dev \
		libqt5xmlpatterns5-dev \
		libboost-all-dev \
		libpythonqt-dev

RUN apt-get install -y \
		ssh \
		debmake

RUN mkdir /build

RUN mkdir /root/.ssh

WORKDIR /build

VOLUME /build

COPY ./entrypoint.sh /entrypoint.sh

COPY ./authorized_keys /root/.ssh

COPY ./setup.sh /setup.sh

COPY ./debian.tar.xz /build/debian.tar.xz

#RUN /setup.sh

ENTRYPOINT /entrypoint.sh
#ENTRYPOINT /bin/bash

