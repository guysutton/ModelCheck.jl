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
include("plot_qq.jl")
export plot_qq

# Function #3: Plot residual vs fitted plot
include("plot_res_fit.jl")
export plot_res_fit

end
