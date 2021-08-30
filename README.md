# ModelCheck

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://guysutton.github.io/ModelCheck.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://guysutton.github.io/ModelCheck.jl/dev)
[![Run tests](https://github.com/guysutton/ModelCheck.jl/actions/workflows/Runtests.yml/badge.svg)](https://github.com/guysutton/ModelCheck.jl/actions/workflows/Runtests.yml)
[![Build Status](https://github.com/guysutton/ModelCheck.jl/workflows/CI/badge.svg)](https://github.com/guysutton/ModelCheck.jl/actions)

`ModelCheck.jl` is a `Julia` package designed to perform model diagnostics for fitted General Linear Models (GLM's). Currently GLM's specificed using `GLM.jl` are supported. 

## Installation

Currently, `ModelCheck.jl` is an unregistered package, and therefore must be downloaded from GitHub directly using the URL to the [ModelCheck.jl](https://github.com/guysutton/ModelCheck.jl) repository:

```julia
julia> ] # Enter the package manager
julia> add https://github.com/guysutton/ModelCheck.jl
```

will install this package and its dependencies, which includes the [Distributions package](https://github.com/JuliaStats/Distributions.jl) and the [GLM package](https://github.com/JuliaStats/GLM.jl).

## Minimal Example

Please consult the [GLM package](https://github.com/JuliaStats/GLM.jl) documentation for details on how to fit a linear model in Julia. A basic example is outlined below.

```julia
# Load packages
julia> using DataFrames, GLM, Distributions, ModelCheck

# Simulate data
julia> data = DataFrame(X=[1,2,3,4,5,6,7,8,9,10], Y=[2,4,7,10,5,2,3,6,7,8])

# Fit simple General Linear Model
julia> m1 = glm(@formula(Y ~ X), data, Distributions.Normal(), GLM.IdentityLink())
StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Normal{Float64}, IdentityLink}, GLM.DensePredChol{Float64, LinearAlgebra.Cholesky{Float64, Matrix{Float64}}}}, Matrix{Float64}}

Y ~ 1 + X

Coefficients:
───────────────────────────────────────────────────────────────────────
                Coef.  Std. Error     z  Pr(>|z|)  Lower 95%  Upper 95%
───────────────────────────────────────────────────────────────────────
(Intercept)  3.86667     1.83919   2.10    0.0355   0.261917   7.47142
X            0.278788    0.296413  0.94    0.3469  -0.30217    0.859746
───────────────────────────────────────────────────────────────────────
```
    
#### 1. ModelCheck - Plot quantile-quantile plot (QQplot)

To plot a standard quantile-quantile plot (QQplot), users must pass the model object to `model`, the name of the DataFrame containing the predictor(s)/covariates(s) to `df`, and the name of the column in `df` containing the predictor variable. 

```julia
julia> plot_qqplot(model = m1, df = data, y = "Y")
```  

<p align="center"> 
<img src="https://github.com/guysutton/ModelCheck.jl/blob/main/docs/src/images/qqplot_example.png" align="center">
</p>  
    
#### 2. ModelCheck - Plot residual vs fitted plot

To plot a standard residual vs fitted plot, users must pass the model object to `model`, the name of the DataFrame containing the predictor(s)/covariates(s) to `df`, and the name of the column in `df` containing the predictor variable. 

```julia
julia> plot_residual_fitted(model = m1, df = data, y = "Y")
```  

<p align="center"> 
<img src="https://github.com/guysutton/ModelCheck.jl/blob/main/docs/src/images/residual_fitted_example.png" align="center">
</p>

#### 3. ModelCheck - Plot scale-location plot  

To plot a standard scale-location plot, users must pass the model object to `model`, the name of the DataFrame containing the predictor(s)/covariates(s) to `df`, and the name of the column in `df` containing the predictor variable. 

```julia
julia> plot_scale_location(model = m1, df = data, y = "Y")
```

<p align="center"> 
<img src="https://github.com/guysutton/ModelCheck.jl/blob/main/docs/src/images/scale_location_example.png" align="center">
</p>

#### 4. ModelCheck - Plot all model diagnostics plots    
  
To plot all three of the above plots together, users must pass the model object to `model`, the name of the DataFrame containing the predictor(s)/covariates(s) to `df`, and the name of the column in `df` containing the predictor variable. 

```julia
julia> plot_model_check(model = m1, df = data, y = "Y")
```

<p align="center"> 
<img src="https://github.com/guysutton/ModelCheck.jl/blob/main/docs/src/images/model_check_example.png" align="center">
</p>

