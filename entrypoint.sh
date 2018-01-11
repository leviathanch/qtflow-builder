#!/bin/bash

env
qmake --version

if [[ "$SETUP" == "true" ]]
then
	git clone --recursive https://github.com/leviathanch/qtflow.git
	git clone https://github.com/leviathanch/graywolf.git
	git clone https://github.com/leviathanch/qrouter.git
	git clone https://github.com/cliffordwolf/yosys.git
fi

#if [[ "BUILD" == "true" ]]
#then
	cd qtflow
	mkdir -p build
	cd build
	QT_SELECT=qt5 qmake ..
	make
	cd ../../graywolf
	mkdir -p build
	cd build
	cmake
	make
	cd ../qrouter
	./configure
	make
	cd ../yosys
	make
	make test
#fi
