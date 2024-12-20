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

cmd "conda activate pyamrex"
cmd "export OMP_NUM_THREADS=1"
cmd "python ${HOME}/exawind/source/amr-wind/tools/generate_native_boundary_plane_header.py -f bndry_file.nc.original -i ../../../02_precursor_shell/neutral_8.6at150.10dTInv_0.75z0_750zi_10x7x1km_feb3/setup_precursor_neutral.i -o"
