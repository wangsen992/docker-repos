FROM wangsen992/ubuntu22_dev:build

# NOTE: in ALCF, BINDINGS for container is done with
# BINDINGS="-B /opt -B /etc/alternatives"
# So those two directories should be available 

ARG USER=wangsen992
USER $USER
WORKDIR /home/$USER

# Install MPICH according to ALCF requirement
WORKDIR /mpich
# Source is available at http://www.mpich.org/static/downloads/
# See installation guide of target MPICH version
# Ex: https://www.mpich.org/static/downloads/4.0.2/mpich-4.0.2-installguide.pdf
# These options are passed to the steps below
ARG MPICH_VERSION="3.3"
ENV MPICH_CONFIGURE_OPTIONS="--prefix=/mpich/install --disable-wrapper-rpath"
ENV MPICH_MAKE_OPTIONS="-j 4"
# Needed for configuration for f77
# Reference: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91731
ENV FFLAGS="-fallow-argument-mismatch"
RUN sudo wget http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
      && sudo tar xfz mpich-${MPICH_VERSION}.tar.gz  --strip-components=1 \
			&& sudo -E ./configure ${MPICH_CONFIGURE_OPTIONS} \
      && sudo -E make install ${MPICH_MAKE_OPTIONS}
ENV PATH $PATH:/mpich/install/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/mpich/install/lib
