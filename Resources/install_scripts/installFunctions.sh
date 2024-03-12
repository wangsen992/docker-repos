#!/bin/bash

TMP_PATH=/tmp
INSTALL_PATH=/app
BLENDER_PREFIX=/app/blender-3.6.9-linux-x64
BLENDER_PYTHON=$BLENDER_PREFIX/3.6/python/bin/python3.10
BLENDER_PYSYS_PATH=$BLENDER_PREFIX/3.6/python/lib/python3.10/site-packages
BLENDER_ADDON_PREFIX=$BLENDER_PREFIX/3.6/scripts/addons

#install blender by downloading tar files from official releases
function install_blender()
{
	BLENDER_FILENAME=blender-3.6.9-linux-x64.tar.xz

	wget -P $TMP_PATH https://mirrors.iu13.net/blender/release/Blender3.6/$BLENDER_FILENAME
	tar xvf $TMP_PATH/$BLENDER_FILENAME -C $INSTALL_PATH
	rm $TMP_PATH/$BLENDER_FILENAME
}

function install_gdal
{
	# dependencies
	sudo apt-get install -y libproj-dev proj-bin proj-data
	pip3 install --target /usr/local/lib/python3.10/dist-packages
	wget -P $TMP_PATH https://github.com/OSGeo/gdal/releases/download/v3.6.4/gdal-3.6.4.tar.gz
	tar xzvf $TMP_PATH/gdal-3.6.4.tar.gz -C $INSTALL_PATH

	CWD=$(pwd)
	cd $INSTALL_PATH/gdal-3.6.4
	mkdir build
	cd build
	cmake ..
	cmake --build .
	cmake --build . --target install
	cd $CWD
}


# create syslink for the gdal python bindings to BLENDER python
function link_gdal()
{
	ln -s /usr/local/lib/python3/dist-packages/GDAL-3.6.4.egg-info ${BLENDER_PYSYS_PATH}/GDAL-3.6.3.egg-info
	ln -s /usr/local/lib/python3/dist-packages/osgeo_utils ${BLENDER_PYSYS_PATH}/osgeo_utils
	ln -s /usr/local/lib/python3/dist-packages/osgeo ${BLENDER_PYSYS_PATH}/osgeo
}

# install BlenderGIS
function install_blendergis()
{
	# install unzip
	sudo apt-get install unzip

	# start working on install
	wget -P $TMP_PATH https://github.com/domlysz/BlenderGIS/archive/refs/tags/228.zip
	unzip $TMP_PATH/228.zip -d $BLENDER_ADDON_PREFIX
	mv $BLENDER_ADDON_PREFIX/BlenderGIS-228 $BLENDER_ADDON_PREFIX/blendergis

	# install pyproj and pillow
	$BLENDER_PYTHON -m pip install pyproj pillow
}

# Prepare development environments for blender
function setup_dev()
{
	# make blender python discoverable by 
	ln -s $BLENDER_PREFIX/3.6/python/bin/python3.10 $BLENDER_PREFIX/3.6/python/bin/python3
	export PATH=$PATH:$BLENDER_PREFIX/3.6/python/bin

	# install python tools in nvim

	echo "setup_dev"
}

# function to install in one go
function install_all()
{
	install_blender
	install_gdal
	link_gdal
	install_blendergis
}

# function to set environments (should be fixed when rebuild base image)
function gdal_shell_init()
{
	echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' >> ~/.bashrc
	echo 'export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3/dist-packages' >> ~/.bashrc
}
