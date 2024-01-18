#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export TZ=Etc/UTC
sudo apt-get install -y \
				python3 python3-distutils python3-pip gcc \
				cmake cmake-curses-gui \
				git curl gawk

