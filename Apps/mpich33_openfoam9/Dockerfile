FROM wangsen992/mpich33:build

SHELL ["/bin/bash", "-c"]
USER wangsen992
RUN sudo apt-get update
RUN sudo apt-get install -y build-essential cmake git ca-certificates
RUN sudo apt-get install -y flex libfl-dev bison zlib1g-dev libboost-system-dev libboost-thread-dev gnuplot libreadline-dev libncurses-dev libxt-dev

WORKDIR /app
RUN sudo chmod -R 775 /app
RUN ls -l /
RUN git clone https://github.com/OpenFOAM/ThirdParty-9.git
WORKDIR /app/ThirdParty-9

WORKDIR /app
RUN git clone -b master-test https://github.com/wangsen992/OpenFOAM-9.git

WORKDIR /app/OpenFOAM-9

RUN sed -i '/export FOAM_INST_DIR/c export FOAM_INST_DIR=/app' etc/bashrc
RUN echo export WM_MPLIB=SYSTEMMPI >> etc/prefs.sh
RUN echo export MPI_ROOT=/mpich >> etc/prefs.sh
RUN echo export MPI_ARCH_INC=-I/mpich/install/include >> etc/prefs.sh
RUN echo export MPI_ARCH_LIBS="\"-L/mpich/install/lib -lmpi\"" >> etc/prefs.sh
RUN echo export MPI_ARCH_FLAGS="\"-DOMPI_SKIP_MPICXX\"" >> etc/prefs.sh
RUN echo export WM_PROJECT_USER_DIR=/app/OpenFOAM-Extra >> etc/prefs.sh

ARG WMAKE_FLAGS="-j4"

WORKDIR /app/ThirdParty-9
RUN . /app/OpenFOAM-9/etc/bashrc && ./Allwmake ${WMAKE_FLAGS}

WORKDIR /app/OpenFOAM-9
RUN . /app/OpenFOAM-9/etc/bashrc && ./Allwmake ${WMAKE_FLAGS}

# Install netcdf-cxx4
WORKDIR /app
RUN git clone -b v4.3.1 https://github.com/Unidata/netcdf-cxx4.git

WORKDIR /app
COPY submit.sh /app/submit.sh
RUN sudo chmod +x /app/submit.sh
ENTRYPOINT ["/app/submit.sh"]
