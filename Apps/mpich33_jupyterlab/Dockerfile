FROM wangsen992/mpich33:build

USER wangsen992

EXPOSE 8888

WORKDIR /app
RUN sudo chmod 775 /app
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
		&& bash Miniconda3-latest-Linux-x86_64.sh -b -p /app/miniconda3
ENV PATH=/app/miniconda3/bin:$PATH
RUN conda init bash && . /home/wangsen992/.bashrc
RUN conda install -c conda-forge -y jupyterlab=3.6.5 \
  && jupyter labextension install @axlair/jupyterlab_vim
RUN conda install -y numpy pandas xarray matplotlib \
										 cartopy dask \
	&& conda install -c conda-forge -y netCDF4 \
	&& pip install dask-labextension

WORKDIR /work
CMD jupyter-lab --ip=0.0.0.0


