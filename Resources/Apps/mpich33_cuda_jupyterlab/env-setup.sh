#!/bin/bash

/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_essential.sh
/bin/bash ${IMAGE_RESOURCES}/install_scripts/install_tmux_nvim.sh
# /bin/bash ${IMAGE_RESOURCES}/install_scripts/install_conda.sh
# /bin/bash ${IMAGE_RESOURCES}/install_scripts/homebrew_install.sh

# To provide access priviledge on ALCF
sudo chmod -R 777 /home/${USER}
