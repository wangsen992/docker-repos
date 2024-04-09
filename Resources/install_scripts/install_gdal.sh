#!/bin/bash

# Limited drivers are installed
sudo apt-get install -y proj-bin libproj-dev swig libcrypto++-dev \
	libnetcdf-dev libnetcdf-c++4-dev
sudo python3 -m pip install numpy

cd /app

wget https://github.com/OSGeo/gdal/releases/download/v3.8.5/gdal-3.8.5.tar.gz
tar xzvf gdal-3.8.5.tar.gz 
rm gdal-3.8.5.tar.gz

cd gdal-3.8.5
mkdir build
cd build

cmake ..
cmake --build .
cmake --build . --target install

echo "export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3" >> /home/${USER}/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> /home/${USER}/.bashrc
