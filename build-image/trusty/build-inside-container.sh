#!/bin/bash

set -euo pipefail
buildcount=$1

echo "Built at $(date) from https://github.com/prezi/scribe/tree/master/build-image/trusty" > /output/README.md

echo 'BUILDING, INSTALLING THRIFT'
cd /build/thrift
./bootstrap.sh
./configure --prefix=/usr
mkdir dist
make -j8 DESTDIR=$(pwd)/dist install
fpm -s dir -t deb -n thrift \
    -C dist \
    -v 1.0.0-dev~$(date +%Y%m%d)~prezi$buildcount \
    -p /output/thrift_VERSION_ARCH.deb \
    -d libglib2.0-dev \
    --description "Built at $(date) from https://github.com/prezi/scribe/tree/master/build-image/trusty" \
    usr
dpkg -i /output/thrift_*.deb

echo 'BUILDING, PACKAGING, INSTALLING FB303'
cd /build/thrift/contrib/fb303
./bootstrap.sh --prefix=/usr --with-thriftpath=/usr/
mkdir dist
make -j8 DESTDIR=$(pwd)/dist install
fpm -s dir -t deb -n thrift-fb303 \
    -C dist \
    -v 1.0.0-dev~$(date +%Y%m%d)~prezi$buildcount \
    -p /output/thrift-fb303_VERSION_ARCH.deb \
    -d thrift \
    --description "Built at $(date) from https://github.com/prezi/scribe/tree/master/build-image/trusty" \
    usr
dpkg -i /output/thrift-fb303*.deb

echo 'BUILDING, PACKAGING SCRIBE'
cd /build/scribe
./bootstrap.sh --prefix=/usr --with-thriftpath=/usr/ --with-fb303path=/usr CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H -DBOOST_FILESYSTEM_VERSION=3" --with-boost-filesystem=boost_filesystem --with-boost-system=boost_system
mkdir dist
make -j8 DESTDIR=$(pwd)/dist install
fpm -s dir -t deb -n scribe \
    -C dist \
    -v 0.2.2~$(date +%Y%m%d)~prezi$buildcount \
    -p /output/scribe_VERSION_ARCH.deb \
    -d thrift \
    -d python-six \
    --description "Built at $(date) from https://github.com/prezi/scribe/tree/master/build-image/trusty" \
    usr
