#!/bin/bash
# set -e

. /app/OpenFOAM-9/etc/bashrc

echo "In submit.sh"
exec "$@"
