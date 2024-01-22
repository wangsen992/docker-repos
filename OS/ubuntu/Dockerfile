# Pull directly from tensorflow as a quick-fix to enable gpu device
# FROM nvidia/cuda:11.8.0-base-ubuntu22.04
ARG BASE=tensorflow/tensorflow:nightly-gpu-jupyter

FROM ${BASE}

# Default values provided here, overridden from either command line
# or compose file. 
ARG DI_RESOURCES=Resources
ARG IMAGE_RESOURCES=/app/Resources
ARG USER
ARG BRANCH
ARG INSTALL_APP_SCRIPT
ARG INSTALL_ENV_SCRIPT

RUN mkdir /app
RUN chmod 777 /app
WORKDIR /app
# COPY Resources
COPY ${DI_RESOURCES} ${IMAGE_RESOURCES}

# Run OS Setup for dev env
RUN bash ${IMAGE_RESOURCES}/install_scripts/install_sudo.sh 

RUN bash ${IMAGE_RESOURCES}/add_user.sh ${USER}
WORKDIR /home/${USER}
USER ${USER}

# Installation of package managers at USER STAGE
RUN bash -c " if [ ! -z {INSTALL_ENV_SCRIPT} ]; then bash ${IMAGE_RESOURCES}/${INSTALL_ENV_SCRIPT}; fi "

# Installation of Applications
# Note "INSTALL_SCRIPT" is taken by mpich so have to use INSTALL_APP_SCRIPT
RUN bash -c " if [ ! -z ${INSTALL_APP_SCRIPT} ]; then bash ${IMAGE_RESOURCES}/${INSTALL_APP_SCRIPT}; fi "
			
