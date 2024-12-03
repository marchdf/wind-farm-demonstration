#!/bin/bash
#SBATCH -J scaling_amr_gpu_1
#SBATCH -o %x.o%j
#SBATCH -A CFD162
#SBATCH -t 2:00:00
#SBATCH -N 1
#SBATCH -S 0

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}

cmd "module unload PrgEnv-cray"
cmd "module load PrgEnv-amd/8.5.0"
cmd "module load cpe/24.07"
cmd "module load amd/6.2.4"
cmd "module load rocm/6.2.4"
cmd "export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
# cmd "export FI_MR_CACHE_MONITOR=memhooks"
# cmd "export FI_CXI_RX_MATCH_MODE=software"
# cmd "export MPICH_SMP_SINGLE_COPY_MODE=NONE"
# cmd "export FI_CXI_DEFAULT_CQ_SIZE=131072"
# cmd "export FI_CXI_CQ_FILL_PERCENT=20"
# cmd "unset MPIR_CVAR_CH4_COLL_SELECTION_TUNING_JSON_FILE"
# cmd "unset MPIR_CVAR_COLL_SELECTION_TUNING_JSON_FILE"
# cmd "unset MPIR_CVAR_CH4_POSIX_COLL_SELECTION_TUNING_JSON_FILE"
cmd "export MPICH_GPU_SUPPORT_ENABLED=1"
cmd "export EXAWIND_MANAGER=${HOME}/exawind/exawind-manager"
cmd "source ${EXAWIND_MANAGER}/start.sh && spack-start"
cmd "spack env activate -d ${EXAWIND_MANAGER}/environments/amr-wind-of"
cmd "spack load amr-wind+netcdf+rocm"
cmd "which amr_wind"
cmd "rsync -avzu --delete ${HOME}/exawind/source/wind-farm-demonstration/demo_case/T*_* ."
for dir in T*_*; do
    cmd 'cp "$(spack location -i rosco)/lib/libdiscon.so" "${dir}/IEA-15-240-RWT-Monopile"';
done
cmd "cp ../../../demo_case.inp ."
cmd "cp ../../../avg_theta.dat ."
cmd "srun -N1 -n8 -c1 --gpus-per-node=8 --gpu-bind=closest amr_wind demo_case.inp amrex.abort_on_out_of_gpu_memory=1 amrex.the_arena_is_managed=0 amr.blocking_factor=16 amr.max_grid_size=128 amrex.use_profiler_syncs=0 amrex.async_out=0 time.max_step=40020 > out.log"
