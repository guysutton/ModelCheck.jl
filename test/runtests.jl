using SafeTestsets

##############################################
# - Run unit tests
##############################################

# Each function has its own .jl file containing a SafeTestset
# - Using the 'SafeTestsets' approach requires each test set to run as a
#   stand alone file (e.g. contains its own Using ... packages code for each function).
# - SafeTestsets runs each test set in its own clean environment - no leakage between
#   environments and test sets.

# (1) Test 'calc_resid_deviance' function
@safetestset "test calc_resid_deviance" begin include("test_calc_resid_deviance.jl") end