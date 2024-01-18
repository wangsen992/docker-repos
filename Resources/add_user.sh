#!/bin/bash

export USER=$1
export USER_HOME=/home/${USER}
useradd --user-group --create-home --shell /bin/bash $USER ;\
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
usermod -a -G root $USER
usermod -a -G sudo $USER

sed -i '4 i source /etc/profile' /home/${USER}/.bashrc

# Must remove those lines so the bashrc can still be sourced in non-interactive
# mode
sed -i "6,10d" /home/${USER}/.bashrc

chmod -R 777 /home/${USER}
