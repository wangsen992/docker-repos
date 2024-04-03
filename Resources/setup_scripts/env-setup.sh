#!/bin/bash

# Set Envs
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:/usr/lib64:/usr/local/lib

# Run install scripts
# /bin/bash ${IMAGE_RESOURCES}/install_scripts/install_mpich33.sh
/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_essential.sh
/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_tmux.sh
/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_kasmvnc.sh
# /bin/bash ${IMAGE_RESOURCES}/install_scripts/install_conda.sh
# /bin/bash ${IMAGE_RESOURCES}/install_scripts/homebrew_install.sh

# To provide access priviledge on ALCF
sudo chmod -R 777 /home/${USER}
