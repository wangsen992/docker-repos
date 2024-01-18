#!/bin/bash
# set -e

. /app/OpenFOAM-8/etc/bashrc

echo "In submit.sh"
exec "$@"
