module ModelCheck

import
    GLM,
    Gadfly,
    Distributions,
    Random,
    StatsModels,
    StatsBase,
    Statistics,
    LinearAlgebra,
    LinRegOutliers,
    Colors
    
# Separate .jl files for each function (have to manually add file, otherwise error)

# Function #1: Calculate deviance residuals
include("calc_deviance_resids.jl")
export calc_deviance_resids

# Function #2: Plot quantile-quantile plot
include("plot_qqplot.jl")
export plot_qqplot

# Function #3: Plot residual vs fitted plot
include("plot_residual_fitted.jl")
export plot_residual_fitted

# Function #4: Plot scale-location plot
include("plot_scale_location.jl")
export plot_scale_location

end
