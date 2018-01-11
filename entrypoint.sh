#!/bin/bash

env
qmake --version

if [[ ! -d /build/qtflow ]]; then git clone --recursive https://github.com/leviathanch/qtflow.git /build/qtflow; fi
mkdir -p /build/qtflow/build
cd /build/qtflow/build
QT_SELECT=qt5 qmake ..
make


if [[ ! -d /build/graywolf ]]; then git clone https://github.com/leviathanch/graywolf.git /build/graywolf; fi
mkdir -p /build/graywolf/build
cd /build/graywolf/build
cmake
make

if [[ ! -d /build/qrouter ]]; then git clone https://github.com/leviathanch/qrouter.git /build/qrouter; fi
cd /build/qrouter
./configure
make

if [[ ! -d /build/yosys ]]; then git clone https://github.com/cliffordwolf/yosys.git /build/yosys; fi
cd /build/yosys
make
make test
