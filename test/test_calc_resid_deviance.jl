##############################################
# - Write tests for calc_resid_deviance
##############################################

# Import dependencies required
using GLMdiagnostics
using Test
using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose

# Import simulated data and linear model to test functions
include("test_simulated_model.jl")

@testset "calc_resid_deviance" begin

    # Test #1
    # - Test that object created by function is of type 'Plot'
    @test   typeof(calc_resid_deviance(model = modPoisson,
                                       df = df,
                                       y = "y")) == Plot

end # End of testing for calc_resid_deviance function