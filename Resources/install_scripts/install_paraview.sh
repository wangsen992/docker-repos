#!/bin/bash

brew install mesa mesa-glu mesalib-glw

cd /app
git clone --recursive https://gitlab.kitware.com/paraview/paraview-superbuild.git
cd paraview-superbuild
git fetch origin
git checkout v5.10.1
git submodule update

cd /app
mkdir paraview-build
cd paraview-build
cmake -DENABLE_mpi=True \
			-DUSE_SYSTEM_mpi=True \
			../paraview-superbuild

make -j 4

