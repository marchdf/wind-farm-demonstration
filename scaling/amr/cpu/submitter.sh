#!/usr/bin/env bash

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}

CWD="$(pwd)"
FDIRS=( "2" "4" "8" "16" "32" "64" "128" "256" "512" )
for FDIR in "${FDIRS[@]}"
do
   cmd "cd ${CWD}/${FDIR}"
   cmd "sbatch frontier.sh"
   cmd "cd ${CWD}"
done
