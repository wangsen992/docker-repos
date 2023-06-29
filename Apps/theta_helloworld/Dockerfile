FROM wangsen992/theta:build

USER wangsen992
RUN pip install mpi4py 

WORKDIR /usr
RUN sudo chmod 775 /usr
COPY resource/source/* /usr/source/
RUN sudo chmod g+w /usr/source
COPY resource/submit.sh /usr/
RUN sudo chmod g+w /usr/submit.sh
RUN mpicc -o /usr/source/mpi_hello_world /usr/source/mpi_hello_world.c

ENTRYPOINT ["/usr/submit.sh"]
