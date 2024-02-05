# Demonstration wind farm case

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
