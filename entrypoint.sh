#!/bin/bash

#if [[ ! -d /build/graywolf ]]; then git clone https://github.com/leviathanch/graywolf.git /build/graywolf; fi
#cd /build/graywolf
#cmake .
#make
#make install

#if [[ ! -d /build/qrouter ]]; then git clone https://github.com/leviathanch/qrouter.git /build/qrouter; fi
#cd /build/qrouter
#./configure
#make
#make install

#if [[ ! -d /build/yosys ]]; then git clone https://github.com/cliffordwolf/yosys.git /build/yosys; fi
#cd /build/yosys
#make
#make test
#make install

if [[ ! -d /build/qtflow ]]; then git clone --recursive https://github.com/leviathanch/qtflow.git /build/qtflow; fi
#mkdir -p /build/qtflow/build
#cd /build/qtflow/build
#cmake ..
#make

# build debian package
cd /build/qtflow
export GIT_REVISION="`git rev-parse --short HEAD`"
export FULL_REVISION="0.1+git$GIT_REVISION"
export PACKAGE_NAME="qtflow-$FULL_REVISION"
export ORIG_SOURCE_NAME="qtflow_$FULL_REVISION.orig.tar.bz2"

# cleaning up
rm -rf ../$PACKAGE_NAME*

# extracting master branch
git archive --prefix="$PACKAGE_NAME/" master > "../$PACKAGE_NAME.tar"
cd /build
tar xf "$PACKAGE_NAME.tar"
rm "$PACKAGE_NAME.tar"

# putting in sub modules
cd /build/qtflow/PythonQt
git archive --prefix=PythonQt/ master > "/build/PythonQt.tar"
cd /build/$PACKAGE_NAME
tar xf "/build/PythonQt.tar"
rm "/build/PythonQt.tar"

# generating an .orig archive
cd /build
tar -cjf "$ORIG_SOURCE_NAME" "$PACKAGE_NAME"

# extracting debian recipes
cd /build/$PACKAGE_NAME
tar xf "/build/debian.tar.xz"
dch --distribution unstable --package "qtflow" --newversion "$FULL_REVISION-1" "Auto fetched most recent revision from GIT"
dpkg-buildpackage -j4

#cd /build
#tar -czf "$PACKAGE_NAME.tar.gz"  "$PACKAGE_NAME/" 

