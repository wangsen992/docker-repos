#!/bin/bash

sudo apt-get install libxml2-dev m4

# compile hdf first
wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-1_12_3.tar.gz
tar xzvf hdf5-1_12_3.tar.gz
cd hdf5-hdf5-1_12_3
./configure --prefix=/usr/local

cd /app
wget https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.2.tar.gz
tar xzvf v4.9.2.tar.gz
cd netcdf-c-4.9.2

NCDIR=/usr/local
NFDIR=/usr/local

CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib \
./configure --prefix=${NFDIR} --disable-hdf5

make check
sudo make install

# download C++ 
cd ../app
wget https://downloads.unidata.ucar.edu/netcdf-cxx/4.3.1/netcdf-cxx4-4.3.1.tar.gz
tar xzvf netcdf-cxx4-4.3.1.tar.gz
cd netcdf-cxx4-4.3.1
mkdir build
cd build 
cmake ..
ctest
sudo make install
