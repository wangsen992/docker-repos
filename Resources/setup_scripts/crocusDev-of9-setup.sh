#!/bin/bash

/bin/bash /app/Resources/install_scripts/install_openfoam9.sh

export USER=$(whoami)
source /home/$USER/.bashrc
echo USER:$USER
# cat /home/$USER/.bashrc
echo PATH=$PATH

BRANCH=devAtm-urban
cd /app
git clone -b ${BRANCH} https://github.com/wangsen992/OpenFOAM-Extra.git
sed -i '/export WM_PROJECT_USER_DIR/c export WM_PROJECT_USER_DIR=/app/OpenFOAM-Extra' ./OpenFOAM-Extra/etc/bashrc 
. ./OpenFOAM-9/etc/bashrc \
		&& . ./OpenFOAM-Extra/etc/bashrc && ./OpenFOAM-Extra/Allwmake

# write a welcome message
sudo chmod -R 777 /home/linuxbrew
sudo chmod -R 777 /home/swang18
sudo chmod -R 777 /app /mpich
