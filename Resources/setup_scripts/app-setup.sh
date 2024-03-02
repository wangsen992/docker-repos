#!/bin/bash
export USER=$(whoami)
source /home/$USER/.bashrc
echo USER:$USER
# cat /home/$USER/.bashrc
echo PATH=$PATH

# enable different line to install required library
/bin/bash /app/Resources/install_scripts/install_openfoam9.sh
