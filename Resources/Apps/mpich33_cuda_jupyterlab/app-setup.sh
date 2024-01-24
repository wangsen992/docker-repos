#!/bin/bash
export USER=$(whoami)
source /home/$USER/.bashrc
echo USER:$USER
# cat /home/$USER/.bashrc
echo PATH=$PATH

# enable different line to install required library
/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_conda.sh
/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_jupyter.sh

