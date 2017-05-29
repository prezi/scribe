FROM ubuntu:trusty

# Accept GPG keys of deb repos we'll use
ADD deb-repo-keys /tmp/deb-repo-keys
RUN apt-key add /tmp/deb-repo-keys && rm /tmp/deb-repo-keys

# Add public deb repos, install S3 apt transport
ADD public-deb-sources.list /etc/apt/sources.list.d/public-deb-sources.list

# Install build dependencies
RUN apt-get update \
 && apt-get install -y g++-4.8 gcc-4.8 build-essential ruby ruby-dev make flex bison libtool \
    libevent-dev automake pkg-config libssl-dev libboost1.55-all-dev libbz2-dev \
    build-essential g++ python2.7-dev python2.7-dbg python-twisted-core python-pip git \
    libglib2.0-dev

# FPM for building .deb packages
RUN gem install --no-ri --no-rdoc fpm

# Get thrift and scribe sources
RUN mkdir -p /build \
 && git clone --depth=1 https://github.com/prezi/scribe.git /build/scribe \
 && git clone --depth=1 --branch scribe-deb https://github.com/prezi/thrift.git /build/thrift

# build script
ADD build-inside-container.sh /build/build.sh
WORKDIR /build
