#!/bin/bash

env
qmake --version

if [[ ! -d /build/graywolf ]]; then git clone https://github.com/leviathanch/graywolf.git /build/graywolf; fi
cd /build/graywolf
cmake .
make
make install

if [[ ! -d /build/qrouter ]]; then git clone https://github.com/leviathanch/qrouter.git /build/qrouter; fi
cd /build/qrouter
./configure
make
make install

if [[ ! -d /build/yosys ]]; then git clone https://github.com/cliffordwolf/yosys.git /build/yosys; fi
cd /build/yosys
make
make test
make install

if [[ ! -d /build/qtflow ]]; then git clone --recursive https://github.com/leviathanch/qtflow.git /build/qtflow; fi
mkdir -p /build/qtflow/build
cd /build/qtflow/build
QT_SELECT=qt5 qmake ..
make

