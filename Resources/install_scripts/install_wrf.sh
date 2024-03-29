#!/bin/bash


sudo apt-get update
sudo apt-get install -y build-essential cmake git ca-certificates automake
sudo apt-get install -y flex libfl-dev bison zlib1g-dev libboost-system-dev \
	libboost-thread-dev gnuplot libreadline-dev libncurses-dev libxt-dev file csh libomp-dev

export DIR=/app/Build_WRF/LIBRARIES
mkdir -p ${DIR}
cd ${DIR}

# Set environment for interactive container shells

export CC=gcc CXX=g++ FC=gfortran F77=gfortran FCFLAGS=-m64 FFLAGS=-m64
export JASPERINC=${DIR}/grib2/include JASPERLIB=${DIR}/grib2/lib
export CPPFLAGS="-I${DIR}/grib2/include -I${DIR}/netcdf/include"
export LD_LIBRARY_PATH $LD_LIBRARY_PATH:${DIR}/netcdf/install/lib:${DIR}/grib2/lib
export LDFLAGS=-L${DIR}/grib2/lib
# Download installation files
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-c-4.7.2.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-fortran-4.5.2.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.11.tar.gz

# Compile netcdf
tar xzvf jasper-1.900.1.tar.gz \
	&& cd jasper-1.900.1 \
	&& cp -f /usr/share/automake*/config.guess acaux/config.guess \
	&& ./configure --prefix=${DIR}/grib2 \
	&& make && make install && cd ..
tar xzvf libpng-1.2.50.tar.gz \
	&& cd libpng-1.2.50 \
	&& cp -f /usr/share/automake*/config.guess ./config.guess \
	&& ./configure --prefix=${DIR}/grib2 \
	&& make && make install && cd ..
tar xzvf zlib-1.2.11.tar.gz \
	&& cd zlib-1.2.11 \
	&& ./configure --prefix=${DIR}/grib2 \
	&& make && make install && cd ..
tar xzvf netcdf-c-4.7.2.tar.gz \
	&& cd netcdf-c-4.7.2 \
	&& ./configure --prefix=${DIR}/netcdf --disable-dap \
								 --disable-netcdf-4 --disable-shared \
	&& make && make install && cd ..

export LIBS="-lnetcdf -lz"
export LDFLAGS="-L${DIR}/netcdf/lib ${LDFLAGS}"
tar xzvf netcdf-fortran-4.5.2.tar.gz \
	&& cd netcdf-fortran-4.5.2 \
 	&& ./configure --prefix=${DIR}/netcdf --disable-dap \
 								 --disable-netcdf-4 --disable-shared \
 	&& make && make install
export NETCDF=${DIR}/netcdf
export PATH=$PATH:${NETCDF}/bin

ln -s /app/Build_WRF/LIBRARIES/netcdf-fortran-4.5.2/fortran/netcdf4.inc /app/Build_WRF/LIBRARIES/netcdf/include/netcdf.inc

# Download WRF and WPS
cd /app
git clone --recurse-submodules https://github.com/wrf-model/WRF
git clone https://github.com/wrf-model/WPS
cd /app/WRF
echo "3\n" | ./configure \
	&& ./compile em_real
cd /app/WPS
echo "3\n" | ./configure  
sed -i 's/-lnetcdff /&-fopenmp /' ./configure.wps \
	&& ./compile

export PATH=/app/WRF/main:/app/WPS/:$PATH

# Prepare environments for WRF
