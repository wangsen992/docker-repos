# This is only to build extension packages to existing theta_openfoam9:build
FROM wangsen992/mpich33_openfoam9:build

SHELL ["/bin/bash", "-c"]
USER wangsen992

ARG BRANCH=devAtm

WORKDIR /app
RUN git clone -b ${BRANCH} https://github.com/wangsen992/OpenFOAM-Extra.git
RUN sed -i '/export WM_PROJECT_USER_DIR/c export WM_PROJECT_USER_DIR=/app/OpenFOAM-Extra' ./OpenFOAM-Extra/etc/bashrc 
RUN . ./OpenFOAM-9/etc/bashrc \
		&& . ./OpenFOAM-Extra/etc/bashrc && ./OpenFOAM-Extra/Allwmake

COPY submit.sh /app/submit.sh
RUN sudo chmod +x /app/submit.sh
ENTRYPOINT ["/app/submit.sh"]
