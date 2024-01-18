#!/bin/bash

source /home/$(whoami)/.bashrc

conda install -c conda-forge -y jupyterlab
pip install jupyterlab-vim
conda install -y numpy pandas xarray matplotlib \
										 cartopy dask \
	&& conda install -c conda-forge -y netCDF4 \
	&& pip install dask-labextension
