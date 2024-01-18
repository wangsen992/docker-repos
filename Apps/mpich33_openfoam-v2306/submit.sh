#!/bin/bash
# set -e

. /app/openfoam/etc/bashrc

echo "In submit.sh"
exec "$@"
