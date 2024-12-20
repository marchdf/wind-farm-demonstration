#!/usr/bin/env bash

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}

CWD="$(pwd)"
FDIRS=( "16" "32" "64" "128" "256" "512" "1024" )
for FDIR in "${FDIRS[@]}"
do
   cmd "cd ${CWD}/${FDIR}"
   cmd "sbatch frontier.sh"
   cmd "cd ${CWD}"
done
