#!/bin/bash
#SBATCH -J refiner
#SBATCH -o %x.o%j
#SBATCH -A CFD162
#SBATCH -t 0:10:00
#SBATCH -N 8
#SBATCH -S 0

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}

cmd "module load PrgEnv-amd"
cmd "module load amd/6.2.4"
# cmd "export FI_MR_CACHE_MONITOR=memhooks"
# cmd "export FI_CXI_RX_MATCH_MODE=software"
# cmd "export MPICH_SMP_SINGLE_COPY_MODE=NONE"
# cmd "export FI_CXI_DEFAULT_CQ_SIZE=131072"
# cmd "export FI_CXI_CQ_FILL_PERCENT=20"
# cmd "unset MPIR_CVAR_CH4_COLL_SELECTION_TUNING_JSON_FILE"
# cmd "unset MPIR_CVAR_COLL_SELECTION_TUNING_JSON_FILE"
# cmd "unset MPIR_CVAR_CH4_POSIX_COLL_SELECTION_TUNING_JSON_FILE"
# cmd "export MPICH_GPU_SUPPORT_ENABLED=1"
cmd "export EXAWIND_MANAGER=${HOME}/exawind/exawind-manager"
cmd "source ${EXAWIND_MANAGER}/start.sh && spack-start"
cmd "spack env activate -d ${EXAWIND_MANAGER}/environments/amr-wind-of"
cmd "spack load amr-wind+netcdf~rocm"
cmd "which amr_wind_refine_chkpt"
cmd "srun -N8 -n448 -c1 amr_wind_refine_chkpt refiner.inp amr.max_level=1 > refiner-0.log"
cmd "mv chk40000 refine-0"
cmd "srun -N8 -n448 -c1 amr_wind_refine_chkpt refiner.inp amr.max_level=1 io.restart_file=refine-0 amr.n_cell=2048 1536 192 > refiner-1.log"
