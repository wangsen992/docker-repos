#!/bin/bash

# Install MPICH according to ALCF requirement
MPICH_DIR=/mpich
mkdir ${MPICH_DIR} && cd ${MPICH_DIR}

# Source is available at http://www.mpich.org/static/downloads/
# See installation guide of target MPICH version
# Ex: https://www.mpich.org/static/downloads/4.0.2/mpich-4.0.2-installguide.pdf
# These options are passed to the steps below
MPICH_VERSION="3.3"
MPICH_CONFIGURE_OPTIONS="--prefix=/mpich/install --disable-wrapper-rpath"
MPICH_MAKE_OPTIONS="-j 4"
# Needed for configuration for f77
# Reference: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91731
export FFLAGS="-fallow-argument-mismatch"
echo Downloading and compiling mpich...
wget http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
      && tar xfz mpich-${MPICH_VERSION}.tar.gz  --strip-components=1 \
			&&  ./configure ${MPICH_CONFIGURE_OPTIONS} \
      && make install ${MPICH_MAKE_OPTIONS}
echo 'export PATH=$PATH:/mpich/install/bin' >> /etc/profile
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mpich/install/lib' >> /etc/profile
