module ModelCheck

import
    GLM,
    Gadfly,
    Distributions,
    Random,
    StatsModels,
    StatsBase,
    Statistics
    
# Separate .jl files for each function (have to manually add file, otherwise error)

# Function #1: Calculate unstandardised deviance residuals for fitted linear model object
include("calc_resid_deviance.jl")
export calc_resid_deviance


end
