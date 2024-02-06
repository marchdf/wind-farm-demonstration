# Demonstration wind farm case

## Software and dependencies

```
$ git clone --recursive git@github.com:marchdf/wind-farm-demonstration.git
$ cp -r submods/ALCC_Frontier_WindFarm/turbines/turbinedef/* submods/amr-wind-frontend/turbines/
```

Also do the following:
1. Change the `Acutator_epsilon` and `Acutator_epsilon_tower` to 5.0 instead of 2.5 in `IEA15MW.yaml`.
2. Change the `DLL_FileName` in `submods/amr-wind-frontend/turbines/OpenFAST3p4_IEA15MW/IEA-15-240-RWT-Monopile/IEA-15-240-RWT-Monopile_ServoDyn.dat` to `libdiscon.so`

## Creating the wind farm

Run `demo_farm.ipynb`.

## Spack environment

Spack manager file, note the ROSCO stuff:
```
# This is a Spack Environment file.
#
# It describes a set of packages to be installed, along with
# configuration settings.
spack:
  # add package specs to the `specs` list
  specs:
  - amr-wind@main+openfast+rocm~shared+tiny_profile+gpu-aware-mpi amdgpu_target=gfx90a ^openfast@git.bb72d2622177ec428af36ad0ee9e8fbdb17c574f~shared+netcdf+cxx ^rosco@2.7
  view: false
  concretizer:
    unify: true
  include:
  - include.yaml
  develop:
    # needs:
    # $ git clone https://github.com/NREL/ROSCO.git rosco
    # $ git remote add marchdf git@github.com:marchdf/ROSCO.git
    # $ git fetch marchdf
    # $ git checkout rosco-27-flang
    rosco:
      spec: rosco@=2.7
    amr-wind:
      spec: amr-wind@=main
```
