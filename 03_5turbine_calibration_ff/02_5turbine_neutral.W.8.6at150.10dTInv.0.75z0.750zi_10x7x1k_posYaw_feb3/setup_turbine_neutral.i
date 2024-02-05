#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            SIMULATION STOP            #
#.......................................#
time.stop_time               = 21800.0     # Max (simulated) time to evolve
time.max_step                =  -1          # Max number of time steps
#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#         TIME STEP COMPUTATION         #
#.......................................#
time.fixed_dt         =   0.02         # Use this constant dt if > 0
time.cfl              =   0.95       # CFL factor
#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            INPUT AND OUTPUT           #
#.......................................#
io.KE_int = -1
io.line_plot_int = 1
#io.restart_file = "/projects/car/rthedin/amr_runs/02_precursor_shell/neutral_8.6at150.10dTInv_0.75z0_750zi_10x7x1km_feb3/chk40000"
io.restart_file = "/lustre/orion/proj-shared/cfd162/marchdf/demo_case/02_precursor_shell/neutral_8.6at150.10dTInv_0.75z0_750zi_10x7x1km_feb3/chk40000"
io.outputs = actuator_src_term
io.derived_outputs = q_criterion
time.plot_interval            =  10000       # Steps between plot files
time.checkpoint_interval      =  15000       # Steps between checkpoint files
#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#               PHYSICS                 #
#.......................................#
incflo.gravity        =  0.0  0.0 -9.81  # Gravitational force (3D)
incflo.density        =  1.225             # Reference density
incflo.use_godunov = 1
incflo.godunov_type = "weno_z"
transport.viscosity = 0.0
transport.laminar_prandtl = 0.7
transport.turbulent_prandtl = 0.3333
turbulence.model = OneEqKsgsM84
incflo.physics = ABL Actuator
ICNS.source_terms = BoussinesqBuoyancy CoriolisForcing BodyForce ActuatorForcing ABLMeanBoussinesq
#---------------- Additions by calc_inflow_stats.py -----------------#
ABL.wall_shear_stress_type = "local"
ABL.inflow_outflow_mode    = true
ABL.wf_velocity            = 2.500245 0.105173
ABL.wf_vmag                = 2.532626503500448
ABL.wf_theta               = 300.00908710012425
BodyForce.magnitude        = 0.00045577915197378074 0.0009349589835232567 0.0
BoussinesqBuoyancy.read_temperature_profile = true
BoussinesqBuoyancy.tprofile_filename        = avg_theta.dat
#--------------------------------------------------------------------#
TKE.source_terms = KsgsM84Src
TKE.interpolation = PiecewiseConstant
BoussinesqBuoyancy.reference_temperature = 300.0
CoriolisForcing.east_vector = 1.0 0.0 0.0
CoriolisForcing.north_vector = 0.0 1.0 0.0
CoriolisForcing.latitude = 40.761  # Mayflower farm
CoriolisForcing.turn_off_vertical_force = True
CoriolisForcing.rotational_time_period = 86400.0

ABLForcing.abl_forcing_height = 150

incflo.velocity = 8.6 0.0 0.0
#mac_proj.verbose=4

ABL.reference_temperature = 300.0
ABL.temperature_heights                  = 0.0 700.0 800.0 1800.0
ABL.temperature_values                   = 300.0 300.0 310.0 313.0
ABL.perturb_temperature = false
ABL.cutoff_height = 50.0
ABL.perturb_velocity = true
ABL.perturb_ref_height = 50.0
ABL.Uperiods = 40.0
ABL.Vperiods = 25.0
ABL.deltaU = 0.25
ABL.deltaV = 0.25
ABL.kappa = .41
ABL.surface_roughness_z0 = 0.75
ABL.normal_direction = 2
# ABL.log_law_height = 5.0
# ABL.stats_output_frequency = 100
# ABL.stats_output_format = netcdf



Actuator.labels = T1 T2 T3 T4 T5
Actuator.type = TurbineFastLine

Actuator.TurbineFastLine.rotor_diameter = 240.0
Actuator.TurbineFastLine.hub_height = 150.
Actuator.TurbineFastLine.num_points_blade = 48
Actuator.TurbineFastLine.num_points_tower = 12
Actuator.TurbineFastLine.epsilon =  2.5 2.5 2.5
Actuator.TurbineFastLine.epsilon_tower = 2.5 2.5 2.5
Actuator.TurbineFastLine.openfast_start_time = 0.0
Actuator.TurbineFastLine.openfast_stop_time = 1801.0
Actuator.TurbineFastLine.nacelle_drag_coeff = 0.5
Actuator.TurbineFastLine.nacelle_area = 49.5
Actuator.TurbineFastLine.output_frequency = 10
Actuator.TurbineFastLine.density = 1.225

# Brooke:
##We want hub at 1772.54 2080.0 150.0. Account for hub-tower distance (overhang * cos(ShftTilt) ) of 12.0313m and Initial yaw angle of of +30 degrees (+z axis)
#Actuator.WTG01.base_position = 1782.95941144 2086.01565 0.0   
#Actuator.WTG01.openfast_input_file = "turbinedata_iea15/IEA15MW_01.fst"
#
##We want hub at 3227.46 2920.0 150.0. Account for hub-tower distance (overhang * cos(ShftTilt) ) of 12.0313m and Initial yaw angle of of +30 degrees (+z axis)
#Actuator.WTG02.base_position = 3248.30150124 2932.0313 0.0
#Actuator.WTG02.openfast_input_file = "turbinedata_iea15/IEA15MW_02.fst"

# hub at 0,0,0, considering overhang of 12.0313
Actuator.T1.base_position = 12. 0. 0.
Actuator.T1.openfast_input_file = "turbine_iea15mw/IEA-15-240-RWT-Monopile.T1.fst"

# hub at 1850,0,0, considering overhang of 12.0313
Actuator.T2.base_position = 1862. 0. 0.
Actuator.T2.openfast_input_file = "turbine_iea15mw/IEA-15-240-RWT-Monopile.T2.fst"

# hub at 3700,0,0, considering overhang of 12.0313
Actuator.T3.base_position = 3712. 0. 0.
Actuator.T3.openfast_input_file = "turbine_iea15mw/IEA-15-240-RWT-Monopile.T3.fst"

# hub at 5550,0,0, considering overhang of 12.0313
Actuator.T4.base_position = 5562. 0. 0.
Actuator.T4.openfast_input_file = "turbine_iea15mw/IEA-15-240-RWT-Monopile.T4.fst"

# hub at 7400,0,0, considering overhang of 12.0313
Actuator.T5.base_position = 7412. 0. 0.
Actuator.T5.openfast_input_file = "turbine_iea15mw/IEA-15-240-RWT-Monopile.T5.fst"



#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#        ADAPTIVE MESH REFINEMENT       #
#.......................................#
geometry.prob_lo        =   -1095. -3845.    0.  # Lo corner coordinates
geometry.prob_hi        =    9145.  3835.  960.  # Hi corner coordinates
amr.n_cell              =  1024 768 96    # Grid cells at coarsest AMRlevel
geometry.is_periodic    =   0   1   0   # Periodicity x y z (0/1)

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#        Mesh refinement                #
#.......................................#
amr.max_level           =  3           # Max AMR level in hierarchy
amr.blocking_factor = 16
amr.max_grid_size = 128

#---- tagging defs ----
tagging.labels                           = Tall_level_0 T1_level_1_zone T2_level_1_zone T3_level_1_zone T4_level_1_zone T5_level_1_zone T1_level_2_zone T2_level_2_zone T3_level_2_zone T4_level_2_zone T5_level_2_zone

tagging.Tall_level_0.type                = GeometryRefinement  
tagging.Tall_level_0.shapes              = Tall_level_0        
tagging.Tall_level_0.level               = 0                   
tagging.Tall_level_0.Tall_level_0.type   = box                 
tagging.Tall_level_0.Tall_level_0.origin = -800.0 -420.0 -10.0 
tagging.Tall_level_0.Tall_level_0.xaxis  = 9300.0 0.0 0.0      
tagging.Tall_level_0.Tall_level_0.yaxis  = -0.0 700.0 -0.0     
tagging.Tall_level_0.Tall_level_0.zaxis  = 0.0 0.0 460.0       

tagging.T1_level_1_zone.type             = GeometryRefinement  
tagging.T1_level_1_zone.shapes           = T1_level_1_zone     
tagging.T1_level_1_zone.level            = 1                   
tagging.T1_level_1_zone.T1_level_1_zone.type = box                 
tagging.T1_level_1_zone.T1_level_1_zone.origin = -502.457340961008 -188.51159251991197 -90.0
tagging.T1_level_1_zone.T1_level_1_zone.xaxis = 1432.1115293303135 -150.52098710542091 0.0
tagging.T1_level_1_zone.T1_level_1_zone.yaxis = 50.17366236847364 477.3705097767712 -0.0
tagging.T1_level_1_zone.T1_level_1_zone.zaxis = 0.0 0.0 480.0       
tagging.T2_level_1_zone.type             = GeometryRefinement  
tagging.T2_level_1_zone.shapes           = T2_level_1_zone     
tagging.T2_level_1_zone.level            = 1                   
tagging.T2_level_1_zone.T2_level_1_zone.type = box                 
tagging.T2_level_1_zone.T2_level_1_zone.origin = 1347.542659038992 -188.51159251991197 -90.0
tagging.T2_level_1_zone.T2_level_1_zone.xaxis = 1432.1115293303135 -150.52098710542091 0.0
tagging.T2_level_1_zone.T2_level_1_zone.yaxis = 50.17366236847364 477.3705097767712 -0.0
tagging.T2_level_1_zone.T2_level_1_zone.zaxis = 0.0 0.0 480.0       
tagging.T3_level_1_zone.type             = GeometryRefinement  
tagging.T3_level_1_zone.shapes           = T3_level_1_zone     
tagging.T3_level_1_zone.level            = 1                   
tagging.T3_level_1_zone.T3_level_1_zone.type = box                 
tagging.T3_level_1_zone.T3_level_1_zone.origin = 3197.542659038992 -188.51159251991197 -90.0
tagging.T3_level_1_zone.T3_level_1_zone.xaxis = 1432.1115293303135 -150.52098710542091 0.0
tagging.T3_level_1_zone.T3_level_1_zone.yaxis = 50.17366236847364 477.3705097767712 -0.0
tagging.T3_level_1_zone.T3_level_1_zone.zaxis = 0.0 0.0 480.0       
tagging.T4_level_1_zone.type             = GeometryRefinement  
tagging.T4_level_1_zone.shapes           = T4_level_1_zone     
tagging.T4_level_1_zone.level            = 1                   
tagging.T4_level_1_zone.T4_level_1_zone.type = box                 
tagging.T4_level_1_zone.T4_level_1_zone.origin = 5054.427702176694 -205.93226466517797 -90.0
tagging.T4_level_1_zone.T4_level_1_zone.xaxis = 1436.492232374147 -100.44932219153965 0.0
tagging.T4_level_1_zone.T4_level_1_zone.yaxis = 33.483107397179886 478.8307441247157 -0.0
tagging.T4_level_1_zone.T4_level_1_zone.zaxis = 0.0 0.0 480.0       
tagging.T5_level_1_zone.type             = GeometryRefinement  
tagging.T5_level_1_zone.shapes           = T5_level_1_zone     
tagging.T5_level_1_zone.level            = 1                   
tagging.T5_level_1_zone.T5_level_1_zone.type = box                 
tagging.T5_level_1_zone.T5_level_1_zone.origin = 6920.0 -239.9999999999999 -90.0
tagging.T5_level_1_zone.T5_level_1_zone.xaxis = 1440.0 -3.5269827815443773e-13 0.0
tagging.T5_level_1_zone.T5_level_1_zone.yaxis = 1.1756609271814592e-13 480.0 -0.0
tagging.T5_level_1_zone.T5_level_1_zone.zaxis = 0.0 0.0 480.0       

tagging.T1_level_2_zone.type             = GeometryRefinement  
tagging.T1_level_2_zone.shapes           = T1_level_2_zone     
tagging.T1_level_2_zone.level            = 2                   
tagging.T1_level_2_zone.T1_level_2_zone.type = box                 
tagging.T1_level_2_zone.T1_level_2_zone.origin = 11.31772457069561 -136.352151103464 18.0
tagging.T1_level_2_zone.T1_level_2_zone.xaxis = 78.9341801460163 28.729692039356195 0.0
tagging.T1_level_2_zone.T1_level_2_zone.yaxis = -90.29331783797662 248.0788518874798 -0.0
tagging.T1_level_2_zone.T1_level_2_zone.zaxis = 0.0 0.0 264.0       
tagging.T2_level_2_zone.type             = GeometryRefinement  
tagging.T2_level_2_zone.shapes           = T2_level_2_zone     
tagging.T2_level_2_zone.level            = 2                   
tagging.T2_level_2_zone.T2_level_2_zone.type = box                 
tagging.T2_level_2_zone.T2_level_2_zone.origin = 1861.3177245706956 -136.352151103464 18.0
tagging.T2_level_2_zone.T2_level_2_zone.xaxis = 78.9341801460163 28.729692039356195 0.0
tagging.T2_level_2_zone.T2_level_2_zone.yaxis = -90.29331783797662 248.0788518874798 -0.0
tagging.T2_level_2_zone.T2_level_2_zone.zaxis = 0.0 0.0 264.0       
tagging.T3_level_2_zone.type             = GeometryRefinement  
tagging.T3_level_2_zone.shapes           = T3_level_2_zone     
tagging.T3_level_2_zone.level            = 2                   
tagging.T3_level_2_zone.T3_level_2_zone.type = box                 
tagging.T3_level_2_zone.T3_level_2_zone.origin = 3711.3177245706956 -136.352151103464 18.0
tagging.T3_level_2_zone.T3_level_2_zone.xaxis = 78.9341801460163 28.729692039356195 0.0
tagging.T3_level_2_zone.T3_level_2_zone.yaxis = -90.29331783797662 248.0788518874798 -0.0
tagging.T3_level_2_zone.T3_level_2_zone.zaxis = 0.0 0.0 264.0       
tagging.T4_level_2_zone.type             = GeometryRefinement  
tagging.T4_level_2_zone.shapes           = T4_level_2_zone     
tagging.T4_level_2_zone.level            = 2                   
tagging.T4_level_2_zone.T4_level_2_zone.type = box                 
tagging.T4_level_2_zone.T4_level_2_zone.origin = 5537.468480343595 -136.24595779362093 18.0
tagging.T4_level_2_zone.T4_level_2_zone.xaxis = 82.72385125302549 14.586446924022113 0.0
tagging.T4_level_2_zone.T4_level_2_zone.yaxis = -45.8431189040695 259.9892467952229 -0.0
tagging.T4_level_2_zone.T4_level_2_zone.zaxis = 0.0 0.0 264.0       
tagging.T5_level_2_zone.type             = GeometryRefinement  
tagging.T5_level_2_zone.shapes           = T5_level_2_zone     
tagging.T5_level_2_zone.level            = 2                   
tagging.T5_level_2_zone.T5_level_2_zone.type = box                 
tagging.T5_level_2_zone.T5_level_2_zone.origin = 7364.0 -132.0 18.0  
tagging.T5_level_2_zone.T5_level_2_zone.xaxis = 84.0 -2.0574066225675533e-14 0.0
tagging.T5_level_2_zone.T5_level_2_zone.yaxis = 6.466135099498025e-14 264.0 -0.0
tagging.T5_level_2_zone.T5_level_2_zone.zaxis = 0.0 0.0 264.0       


#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#              GEOMETRY                 #
#.......................................#
# Boundary conditions
xlo.type = "mass_inflow"
xlo.density = 1.225
xlo.temperature=0
xlo.tke=0
xhi.type = "pressure_outflow"

zlo.type =   "wall_model"
zlo.temperature_type = "fixed_gradient"
zlo.temperature = 0.0
zlo.tke_type = "zero_gradient"
zhi.type =   "slip_wall"
zhi.temperature_type = "fixed_gradient"
zhi.temperature = 0.003
incflo.verbose          =   0

# MLMG settings
nodal_proj.mg_rtol = 1.0e-6
nodal_proj.mg_atol = 1.0e-12
mac_proj.mg_rtol = 1.0e-6
mac_proj.mg_atol = 1.0e-12
diffusion.mg_rtol = 1.0e-6
diffusion.mg_atol = 1.0e-12
temperature_diffusion.mg_rtol = 1.0e-10
temperature_diffusion.mg_atol = 1.0e-13


#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#          POST-Processing              #
#.......................................#
#io.output_hdf5_plotfile                  = true
#io.hdf5_compression                      = "ZFP_ACCURACY@0.001"

incflo.post_processing                   = averaging ynormal znormal planesT1 planesT2 planesT3 planesT4 planesT5

# --- Sampling parameters ---
ynormal.output_format    = netcdf
ynormal.output_frequency = 50  # every 1 s
ynormal.fields           = velocity temperature
#---- sample defs ----
ynormal.labels               = ynormal
ynormal.ynormal.type         = PlaneSampler
ynormal.ynormal.num_points   = 1971 161
ynormal.ynormal.origin       = -750   0   1
ynormal.ynormal.axis1        = 9850   0.0   0.0
ynormal.ynormal.axis2        = 0.0    0.0   800
ynormal.ynormal.normal       = 0.0    1.0   0.0
ynormal.ynormal.offsets      = 0 

# --- Sampling parameters ---
znormal.output_format    = netcdf
znormal.output_frequency = 50  # every 1 s
znormal.fields           = velocity temperature
#---- sample defs ----
znormal.labels               = znormal
znormal.znormal.type         = PlaneSampler
znormal.znormal.num_points   = 1971 801
znormal.znormal.origin       = -750   -2000   150
znormal.znormal.axis1        = 9850   0.0      0.0
znormal.znormal.axis2        = 0.0    4000.0   0.0
znormal.znormal.normal       = 0.0    0.0      1.0
znormal.znormal.offsets      = 0 


# --- Sampling parameters ---
planesT1.output_format    = netcdf
planesT1.output_frequency = 50  # every 1 s
planesT1.fields           = velocity temperature
#---- sample defs ----
planesT1.labels           = pT1
planesT1.pT1.type         = PlaneSampler
planesT1.pT1.num_points   = 201 101
planesT1.pT1.origin       = 5      -500   15
planesT1.pT1.axis1        = 0.0   1000   0.0
planesT1.pT1.axis2        = 0.0    0.0   500
planesT1.pT1.normal       = 1.0    0.0   0.0
planesT1.pT1.offsets      = 0  120.0 240 480 720 960 1200 1440

# --- Sampling parameters ---
planesT2.output_format    = netcdf
planesT2.output_frequency = 50  # every 1 s
planesT2.fields           = velocity temperature
#---- sample defs ----
planesT2.labels           = pT2
planesT2.pT2.type         = PlaneSampler
planesT2.pT2.num_points   = 201 101
planesT2.pT2.origin       = 1855   -500   15
planesT2.pT2.axis1        = 0.0   1000   0.0
planesT2.pT2.axis2        = 0.0    0.0   500
planesT2.pT2.normal       = 1.0    0.0   0.0
planesT2.pT2.offsets      = 0 120.0 240 480 720 960 1200 1440

# --- Sampling parameters ---
planesT3.output_format    = netcdf
planesT3.output_frequency = 50  # every 1 s
planesT3.fields           = velocity temperature
#---- sample defs ----
planesT3.labels           = pT3
planesT3.pT3.type         = PlaneSampler
planesT3.pT3.num_points   = 201 101
planesT3.pT3.origin       = 3705   -500   15
planesT3.pT3.axis1        = 0.0   1000   0.0
planesT3.pT3.axis2        = 0.0    0.0   500
planesT3.pT3.normal       = 1.0    0.0   0.0
planesT3.pT3.offsets      = 0 120.0 240 480 720 960 1200 1440

# --- Sampling parameters ---
planesT4.output_format    = netcdf
planesT4.output_frequency = 50  # every 1 s
planesT4.fields           = velocity temperature
#---- sample defs ----
planesT4.labels           = pT4
planesT4.pT4.type         = PlaneSampler
planesT4.pT4.num_points   = 201 101
planesT4.pT4.origin       = 5555   -500   15
planesT4.pT4.axis1        = 0.0   1000   0.0
planesT4.pT4.axis2        = 0.0    0.0   500
planesT4.pT4.normal       = 1.0    0.0   0.0
planesT4.pT4.offsets      = 0 120.0 240 480 720 960 1200 1440

# --- Sampling parameters ---
planesT5.output_format    = netcdf
planesT5.output_frequency = 50  # every 1 s
planesT5.fields           = velocity temperature
#---- sample defs ----
planesT5.labels           = pT5
planesT5.pT5.type         = PlaneSampler
planesT5.pT5.num_points   = 201 101
planesT5.pT5.origin       = 7405   -500   15
planesT5.pT5.axis1        =  0.0   1000   0.0
planesT5.pT5.axis2        =  0.0    0.0   500
planesT5.pT5.normal       =  1.0    0.0   0.0
planesT5.pT5.offsets      = 0 120.0 240 480 720 960 1200 1440


#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
# Boundary data sampling for IO         #
#.......................................#
# ABL.bndry_file = "/projects/car/rthedin/amr_runs/02_precursor_shell/neutral_8.6at150.10dTInv_0.75z0_750zi_10x7x1km_feb3/bndry_file.nc"
ABL.bndry_file = "/lustre/orion/proj-shared/cfd162/marchdf/demo_case/02_precursor_shell/neutral_8.6at150.10dTInv_0.75z0_750zi_10x7x1km_feb3/bndry_file.nc"

ABL.bndry_io_mode = 1
ABL.bndry_planes = xlo
ABL.bndry_output_start_time = 20000.0
ABL.bndry_var_names = velocity temperature tke
ABL.bndry_output_format = native

# The time averaging
averaging.type = TimeAveraging
averaging.labels = means  stress

averaging.averaging_window = 300.0
averaging.averaging_start_time = 20900.0

averaging.means.fields = velocity
averaging.means.averaging_type = ReAveraging

averaging.stress.fields = velocity
averaging.stress.averaging_type = ReynoldsStress
