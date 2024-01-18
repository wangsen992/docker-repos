#!/bin/bash

export USER=$(whoami)
source /home/$USER/.bashrc
echo USER:$USER
# cat /home/$USER/.bashrc
echo PATH=$PATH

# brew install cgal and scip for cgal shape reconstruction
# [2023-09-20] cgal install through apt. The version from brew doesn't compile
# well
sudo apt-get install libcgal-dev
brew install scip

# write a welcome message
sudo chmod -R 777 /home/linuxbrew
sudo chmod -R 777 /home/swang18
sudo chmod -R 777 /app /mpich
