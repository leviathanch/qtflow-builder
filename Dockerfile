FROM debian:stretch

RUN 	DEBIAN_FRONTENT=noninteractive apt-get update && \
	apt-get install -y \
		qt5-qmake \
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
		pkg-config

RUN mkdir /build

WORKDIR /build

VOLUME /build

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh


