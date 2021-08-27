using Test
using SafeTestsets
using ModelCheck

using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose
using Colors
using SafeTestsets

# Import simulated data and general linear model to test functions
include("test_simulated_model.jl")

##############################################
# - Run unit tests
##############################################

@testset "ModelCheck Tests" begin

# Test #1: Test that plot_qq returns an object of type 'Plot' when using Poisson GLM
@test   typeof(plot_qqplot(model = modPoisson,
                           df = df,
                           y = "y")) == Plot

# Test #2: Test that plot_residual_fitted returns an object of type 'Plot' when using Poisson GLM
@test   typeof(plot_residual_fitted(model = modPoisson,
                                    df = df,
                                    y = "y")) == Plot

# Test #3: Test that plot_scale_location returns an object of type 'Plot' when using Poisson GLM
@test   typeof(plot_scale_location(model = modPoisson,
                                   df = df,
                                   y = "y")) == Plot

# Test #4: Test that plot_model_check returns an object of type 'Context' when using Poisson GLM
@test   typeof(plot_model_check(model = modPoisson,
                                df = df,
                                y = "y")) == Context

# Test #5: Test that plot_model_check returns an object of type 'Vector{Float64}' when using Poisson GLM
@test   typeof(calc_deviance_resids(model = modPoisson,
                                    df = df,
                                    y = "y")) == Vector{Float64}

end