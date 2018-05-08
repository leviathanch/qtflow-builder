#!/bin/bash
export LANGUAGE="en_US"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_HK.UTF-8"

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
cd /build/qtflow
git pull
git submodule update --init

if [[ ! -d /build/qtflow/debian ]]; then git clone --recursive https://github.com/leviathanch/qtflow-debian.git /build/qtflow/debian; fi
cd /build/qtflow/debian
git pull
git submodule update --init

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
export NAME="`git --no-pager show -s --format='%an' $GIT_REVISION`"
export EMAIL="`git --no-pager show -s --format='%ae' $GIT_REVISION`"
export DEBFULLNAME="$NAME"
export DEBEMAIL="$EMAIL"
export COMMIT_MESSAGE="`git --no-pager show -s --format='%B' $GIT_REVISION`"

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
cd /build/qtflow
if [[ -f /build/qtflow/debian/changelog ]]; then
	dch --distribution unstable --package "qtflow" --newversion "$FULL_REVISION-1" "$COMMIT_MESSAGE";
else
	dch --create --distribution unstable --package "qtflow" --newversion "$FULL_REVISION-1" "$COMMIT_MESSAGE";
fi

cd debian
git add changelog
git commit changelog -m "Docker auto build. GIT message $COMMIT_MESSAGE from revision $GIT_REVISION"
cd ..

dpkg-buildpackage -j4;

#cd /build
#tar -czf "$PACKAGE_NAME.tar.gz"  "$PACKAGE_NAME/" 

