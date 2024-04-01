#!/bin/bash

. ../etc/bashrc

function hello_world
{
	echo hellow world
}

# Function used to create an app with a base OS configuration file
# -base option will be either absolute or relative path to the OS 
# -name will be the name of the app, can be a absolute or relative path too
# Example: create_app -b ../Resource/OS/Ubuntu -n blender
function create_app
{
	while getopts b:n: flag
	do
		case "${flag}" in
			b) base=${OPTARG};;
			n) name=${OPTARG};;
		esac
	done

	echo "base=$base"
	echo "name=$name"

	# Create the app
	cp -r $base $name

}	
