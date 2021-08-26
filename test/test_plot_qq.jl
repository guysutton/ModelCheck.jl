##############################################
# - Write tests for plot_qq function
##############################################

# Import dependencies required
using Test
using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose
using Colors
using ModelCheck

# Import simulated data and general linear model to test functions
include("test_simulated_model.jl")

@testset "plot_qqplot" begin

    # Test #1
    # - Test that object created by function is of type 'Plot'
    @test   typeof(plot_qqplot(model = modPoisson,
                           df = df,
                           y = "y")) == Plot

end # End of testing for plot_qq function