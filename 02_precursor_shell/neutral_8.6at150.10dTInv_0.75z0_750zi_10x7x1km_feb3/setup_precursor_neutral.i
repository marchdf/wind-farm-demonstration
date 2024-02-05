#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#          SIMULATION CONTROL           #
#.......................................#
time.stop_time               =   21800.0     # Max (simulated) time to evolve
time.max_step                =   -1         # Max number of time steps
time.fixed_dt         =   0.5        # Use this constant dt if > 0
time.cfl              =   0.95         # CFL factor

incflo.verbose                           =   1          # incflo_level

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            INPUT AND OUTPUT           #
#.......................................#
time.plot_interval            =  10000       # Steps between plot files
time.checkpoint_interval      =  10000       # Steps between checkpoint files

ABL.bndry_file = "bndry_file.nc"
ABL.bndry_io_mode = 0
ABL.bndry_planes = xlo
ABL.bndry_output_start_time = 19999.0
ABL.bndry_output_format = native
ABL.bndry_var_names = velocity temperature tke

#io.restart_file                          = unused

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            GEOMETRY & BCs             #
#.......................................#
geometry.prob_lo        =   -1095. -3845.    0.  # Lo corner coordinates
geometry.prob_hi        =    9145.  3835.  960.  # Hi corner coordinates
amr.n_cell              =  1024 768 96    # Grid cells at coarsest AMRlevel
amr.max_level           = 0           # Max AMR level in hierarchy 
geometry.is_periodic    =   1   1   0   # Periodicity x y z (0/1)
incflo.delp             =   0.  0.  0.  # Prescribed (cyclic) pressure gradient


# Boundary conditions

zlo.type                                 = wall_model
zlo.temperature_type = "fixed_gradient"
zlo.temperature = 0.0
zhi.type =   "slip_wall"
zhi.temperature_type = "fixed_gradient"
zhi.temperature = 0.003
zlo.tke_type = "zero_gradient"


#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#        Mesh refinement                #
#.......................................#

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#               PHYSICS                 #
#.......................................#
ICNS.source_terms = CoriolisForcing ABLForcing BoussinesqBuoyancy ABLMeanBoussinesq
incflo.velocity = 8.6 0.0 0.0

ABLForcing.abl_forcing_height= 150.

CoriolisForcing.latitude = 40.761  # Mayflower farm
CoriolisForcing.east_vector = 1.0 0.0 0.0
CoriolisForcing.north_vector = 0.0 1.0 0.0
CoriolisForcing.turn_off_vertical_force = True
CoriolisForcing.rotational_time_period = 86400.0

incflo.physics = ABL

BoussinesqBuoyancy.reference_temperature = 300.0
ABL.reference_temperature = 300.0
ABL.temperature_heights                  = 0.0 700.0 800.0 1800.0
ABL.temperature_values                   = 300.0 300.0 310.0 313.0
ABL.perturb_temperature = false
ABL.cutoff_height = 50.0
ABL.perturb_velocity = true
ABL.perturb_ref_height = 50.0
ABL.Uperiods = 40.0
ABL.Vperiods = 24.0
ABL.deltaU = 0.25
ABL.deltaV = 0.25
ABL.kappa = .41
ABL.surface_roughness_z0 = 0.75
ABL.surface_temp_flux                    = 0.0
ABL.log_law_height = 5.0
ABL.stats_output_frequency = 100
ABL.stats_output_format = netcdf

incflo.use_godunov                       = 1
incflo.godunov_type = "weno_z"
incflo.gravity          =   0.  0. -9.81  # Gravitational force (3D)
incflo.density          = 1.225          # Reference density
transport.viscosity = 1.0e-5
transport.laminar_prandtl = 0.7
transport.turbulent_prandtl = 0.3333
turbulence.model = OneEqKsgsM84
#Smagorinsky_coeffs.Cs = 0.08
#TKE.source_terms                         = KsgsM84Src
#TKE.interpolation                        = PiecewiseConstant          


#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#          POST-Processing              #
#.......................................#
#io.output_hdf5_plotfile                  = true
#io.hdf5_compression                      = "ZFP_ACCURACY@0.001"

incflo.post_processing                   = averaging

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#              AVERAGING                #
#.......................................#
averaging.type                           = TimeAveraging
averaging.labels                         = means stress

averaging.averaging_window               = 600.0
averaging.averaging_start_time           = 20000

averaging.means.fields                   = velocity
averaging.means.averaging_type           = ReAveraging

averaging.stress.fields                  = velocity
averaging.stress.averaging_type          = ReynoldsStress

