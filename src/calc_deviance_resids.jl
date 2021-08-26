function calc_deviance_resids(;model, df, y)
    
    ###################################################
    # Section #1: Extract response vector and model residuals 
    ###################################################

    # Extract fitted/predicted values from model object
    pred = GLM.predict(model)

    # Extract vector containing response variable 
    response_y = df[!, y]

    ###################################################
    # Section #2: Calculate deviance residuals
    #             - requires conditional statements to 
    #               loop through different data distributions
    ###################################################

    # Extract statistical distribution specified in model 
    distType = typeof(model).parameters[1].parameters[1].parameters[2]
    distType = string.(distType)

    # Use if-elseif-else statements to calculate deviance residuals depending
    # on which errors were specified during model specification 

        # If model was specified with Poisson errors
        if distType == "Poisson{Float64}"
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Poisson(), response_y, pred))

        # If model was specified with negative binomial errors
        elseif distType == "NegativeBinomial{Float64}"
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.NegativeBinomial(), response_y, pred))

        elseif distType == "Normal{Float64}"
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Normal(), response_y, pred))
        
        # If model was specified with Gamma errors
        elseif distType == "Gamma{Float64}"
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Gamma(), response_y, pred))
        
        # If model was specified with Bernoulli errors 
        elseif distType == "Bernoulli{Float64}"
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Bernoulli(), response_y, pred))
        
        # If model was specified with Binomial errors 
        elseif distType == "Binomial{Float64}"
            sign.(response_y .- pred) .* sqrt.(GLM.devresid.(Distributions.Binomial(), response_y, pred))

        # If model was specified with unsupported error distribution (e.g. tweedie)
        else 
            println("ERROR: Unsupported error distribution specified. 
                    Please refer to GLM.jl documentation for supported error distributions.")
        
        end 
end