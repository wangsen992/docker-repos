#!/bin/bash

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
			&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /app/miniconda3

# Initialize conda for active user
echo 'Setting up environment for conda'

export USER=$(id -un)
echo '# Added to allow system wide access to conda' >> /home/$USER/.bashrc
echo 'export PATH=/app/miniconda3/bin:$PATH' >> /home/$USER/.bashrc
source /home/$USER/.bashrc
/app/miniconda3/bin/conda init

echo "conda is not activated and run code below to activate:\n" \
	"		conda activate "
# conda install -c conda-forge -y jupyterlab \ 
# 		&& pip install jupyterlab-vim
# conda install -y numpy pandas xarray matplotlib \
# 										 cartopy dask \
# 	&& conda install -c conda-forge -y netCDF4 \
# 	&& pip install dask-labextension
