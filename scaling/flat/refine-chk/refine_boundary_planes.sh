#!/bin/bash
#SBATCH -J refiner
#SBATCH -o %x.o%j
#SBATCH -A CFD162
#SBATCH -t 1:00:00
#SBATCH -N 1
#SBATCH -S 0

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}

cmd "module load PrgEnv-gnu/8.5.0"
cmd "module load miniforge3"
CONDA_DIR="$(conda info --base)"
CONDA_EXEC="conda"
cmd "source ${CONDA_DIR}/etc/profile.d/conda.sh"

cmd "mkdir -p refine_boundary_planes"
cmd "cd refine_boundary_planes"
cmd "conda activate pyamrex"
cmd "export OMP_NUM_THREADS=1"
cmd "python ${HOME}/exawind/source/amr-wind/tools/refine_native_boundary_plane.py -f ../bndry_file.nc.original -r 4"
