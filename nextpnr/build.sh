#!/bin/bash

set -e
set -x

if [ x"$TRAVIS" = xtrue ]; then
	CPU_COUNT=2
    if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
	    cat /proc/meminfo
    fi
else
	CPU_COUNT=$(nproc)
fi

cmake -DARCH=ice40 -DBUILD_GUI=OFF -DICEBOX_ROOT=${PREFIX}/share/icebox -DCMAKE_INSTALL_PREFIX=/ -DENABLE_READLINE=No .
make -k -j${CPU_COUNT} || true
make

make DESTDIR=${PREFIX} install
