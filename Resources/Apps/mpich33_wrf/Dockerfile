FROM wangsen992/mpich33:build

SHELL ["/bin/bash", "-c"]
USER wangsen992
RUN sudo apt-get update
RUN sudo apt-get install -y build-essential cmake git ca-certificates
RUN sudo apt-get install -y flex libfl-dev bison zlib1g-dev libboost-system-dev \
	libboost-thread-dev gnuplot libreadline-dev libncurses-dev libxt-dev file csh libomp-dev

WORKDIR /app
RUN sudo chmod -R 775 /app

ENV DIR=/app/Build_WRF/LIBRARIES
RUN mkdir -p ${DIR}
WORKDIR ${DIR}

# Set environment for interactive container shells

ENV CC=gcc CXX=g++ FCFLAGS=-m64 FFLAGS=-m64
ENV JASPERINC=${DIR}/grib2/include JASPERLIB=${DIR}/grib2/lib
ENV CPPFLAGS="-I${DIR}/grib2/include -I${DIR}/netcdf/include"
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:${DIR}/netcdf/install/lib:${DIR}/grib2/lib
ENV LDFLAGS=-L${DIR}/grib2/lib
# Download installation files
RUN wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-c-4.7.2.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-fortran-4.5.2.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz \
		&& wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.11.tar.gz

# Compile netcdf
RUN tar xzvf jasper-1.900.1.tar.gz \
	&& cd jasper-1.900.1 \
	&& ./configure --prefix=${DIR}/grib2 \
	&& make && make install && cd ..
RUN tar xzvf libpng-1.2.50.tar.gz \
	&& cd libpng-1.2.50 \
	&& ./configure --prefix=${DIR}/grib2 \
	&& make && make install && cd ..
RUN tar xzvf zlib-1.2.11.tar.gz \
	&& cd zlib-1.2.11 \
	&& ./configure --prefix=${DIR}/grib2 \
	&& make && make install && cd ..
RUN tar xzvf netcdf-c-4.7.2.tar.gz \ 
	&& cd netcdf-c-4.7.2 \
	&& ./configure --prefix=${DIR}/netcdf --disable-dap \
								 --disable-netcdf-4 --disable-shared \
	&& make && make install

ENV LIBS="-lnetcdf -lz"
ENV LDFLAGS="-L${DIR}/netcdf/lib ${LDFLAGS}"
RUN tar xzvf netcdf-fortran-4.5.2.tar.gz \
	&& cd netcdf-fortran-4.5.2 \
 	&& ./configure --prefix=${DIR}/netcdf --disable-dap \
 								 --disable-netcdf-4 --disable-shared \
 	&& make && make install
ENV NETCDF=${DIR}/netcdf
ENV PATH=$PATH:${NETCDF}/bin

# Download WRF and WPS
WORKDIR /app
RUN git clone --recurse-submodules https://github.com/wrf-model/WRF \ 
	&& git clone https://github.com/wrf-model/WPS
WORKDIR /app/WRF
RUN echo "35/n" | ./configure \
	&& ./compile em_real
WORKDIR /app/WPS
RUN echo 3 | ./configure \ 
	&& sed -i 's/-lnetcdff /&-fopenmp /' ./configure.wps \
	&& ./compile

WORKDIR /app
ENV PATH=/app/WRF/main:/app/WPS/:$PATH

WORKDIR /app
COPY submit.sh /app/submit.sh
RUN sudo chmod +x /app/submit.sh
ENTRYPOINT ["/app/submit.sh"]
