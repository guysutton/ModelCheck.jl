# Import dependencies
using Test
using Distributions
using Random
using DataFrames
using StatsBase
using GLM
using Gadfly
using Statistics
using Compose

###########################################
# - Create simulated data to test functions
###########################################

# Set reproducible seed
Random.seed!(123)

# Simulate n = 100 data points from a Poisson distribution (lambda = 7)
y = Base.rand(Distributions.Poisson(7), 100)

# Assign grouping variables (5 groups of 20)
x = Base.repeat([1, 2, 3, 4, 5],
                inner = 20,
                outer = 1)

# Create dataframe of response and predictor variables 
df = DataFrame(; y, x)

##########################################
# - Run Poisson GLM 
##########################################

# Run Poisson GLM
modPoisson = fit(GeneralizedLinearModel,
                    @formula(y ~ 1 + x),
                    df,
                    Distributions.Poisson(),
                    GLM.LogLink())
