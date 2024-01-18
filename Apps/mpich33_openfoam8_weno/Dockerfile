# This is only to build extension packages to existing theta_openfoam9:build
FROM wangsen992/mpich33_openfoam8:build

SHELL ["/bin/bash", "-c"]
USER wangsen992

WORKDIR /app
RUN git clone --recursive https://github.com/WENO-OF/WENOEXT.git
WORKDIR /app/WENOEXT
RUN . ../OpenFOAM-8/etc/bashrc \
		&& ./Allwmake -j 2 -f
WORKDIR /app

COPY submit.sh /app/submit.sh
RUN sudo chmod +x /app/submit.sh
ENTRYPOINT ["/app/submit.sh"]
