#!/bin/bash

# Source bashrc to ensure environment is up-to-date
echo USER: $USER
. /home/$USER/.bashrc

sudo apt-get update
sudo apt-get install -y build-essential cmake git ca-certificates
sudo apt-get install -y flex libfl-dev bison zlib1g-dev libboost-system-dev libboost-thread-dev gnuplot libreadline-dev libncurses-dev libxt-dev

cd /app
git clone https://github.com/OpenFOAM/ThirdParty-9.git
git clone -b master-test https://github.com/wangsen992/OpenFOAM-9.git

# pull from the latest official OF9
cd /app/OpenFOAM-9
git remote add upstream https://github.com/wangsen992/OpenFOAM-9.git
git pull --rebase upstream master

sed -i '/export FOAM_INST_DIR/c export FOAM_INST_DIR=/app' etc/bashrc
echo export WM_MPLIB=SYSTEMMPI >> etc/prefs.sh
echo export MPI_ROOT=/mpich >> etc/prefs.sh
echo export MPI_ARCH_INC=-I/mpich/install/include >> etc/prefs.sh
echo export MPI_ARCH_LIBS="\"-L/mpich/install/lib -lmpi\"" >> etc/prefs.sh
echo export MPI_ARCH_FLAGS="\"-DOMPI_SKIP_MPICXX\"" >> etc/prefs.sh
echo export WM_PROJECT_USER_DIR=/app/OpenFOAM-Extra >> etc/prefs.sh
echo 'export PATH=$PATH:/mpich/install/bin' >> etc/prefs.sh
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mpich/install/lib' >> etc/prefs.sh

WMAKE_FLAGS="-j4"

# cd /app/ThirdParty-9
# . /app/OpenFOAM-9/etc/bashrc && ./Allwmake ${WMAKE_FLAGS}
# sudo apt-get install -y libscotch-dev libptscotch-dev

cd /app/OpenFOAM-9
. /app/OpenFOAM-9/etc/bashrc

./Allwmake ${WMAKE_FLAGS}

echo '. /app/OpenFOAM-9/etc/bashrc' >> /home/$USER/.bashrc
