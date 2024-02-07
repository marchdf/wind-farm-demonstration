#!/bin/bash
#SBATCH -J demo_case
#SBATCH -o %x.o%j
#SBATCH -A CFD162
#SBATCH -t 30
#SBATCH -q debug
#SBATCH -N 1
#SBATCH -S 0

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}

cmd "module unload PrgEnv-cray"
cmd "module load PrgEnv-amd"
cmd "module load amd/5.4.3"
cmd "export FI_MR_CACHE_MONITOR=memhooks"
cmd "export FI_CXI_RX_MATCH_MODE=software"
cmd "export MPICH_SMP_SINGLE_COPY_MODE=NONE"
cmd "export MPICH_GPU_SUPPORT_ENABLED=1"
cmd "export SPACK_MANAGER=${HOME}/exawind/spack-manager"
cmd "source ${SPACK_MANAGER}/start.sh && spack-start"
cmd "spack env activate -d ${SPACK_MANAGER}/environments/amr-wind-of"
cmd "spack load amr-wind"
cmd "which amr_wind"
cmd "srun -N1 -n8 -c1 --gpus-per-node=8 --gpu-bind=closest amr_wind demo_case.inp amrex.abort_on_out_of_gpu_memory=1 amrex.the_arena_is_managed=0 amr.blocking_factor=16 amr.max_grid_size=128 amrex.use_profiler_syncs=0 amrex.async_out=0 time.max_step=129999"
