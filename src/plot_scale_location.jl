# Write function to automate plotting scale-location plot
# - Plots standard scale-location plot for assessing linear model fits

function plot_scale_location(;model, df, y)

    # Uses an if-else statement to either plot Standardised Pearson residuals
    # if the model is fit with a Gaussian/Normal distribution, or 
    # Standardised deviance residuals if the model is fit with an 
    # exponential family (e.g. Poisson) or any non-Gaussian data distribution.

    ###################################################
    # - Setup and defaults
    ###################################################

    # Set Gadfly theme  
    default_theme = Gadfly.Theme(
        panel_fill = nothing,
        #highlight_width = 0,
        #point_size = 0.8,
        key_position = :inside,
        #grid_line_width = 0,
        panel_stroke = Colors.colorant"black",
        background_color = Colors.colorant"white")
    Gadfly.push_theme(default_theme)

    ###################################################
    # - Plot either Pearson or deviance residuals
    ###################################################

    # Extract statistical distribution specified in model 
    distType = typeof(model).parameters[1].parameters[1].parameters[2]
    distType = string.(distType)

    # Calculate and plot Standardised Pearson Residuals if model was
    # fit with a Gaussian distribution 
    if distType == "Normal{Float64}"

        ###################################################
        # - Calculate raw Pearson residuals
        ###################################################

        # Extract fitted/predicted values from model object
        pred = GLM.predict(model)

        # Extract vector of response values 
        resp = df[!, y]

        # Calculate raw residuals 
        resids = resp .- pred

        # Calculate standard deviation of observed value
        sdResp = Statistics.std(resp)

        # Calculate length (n) of response vector
        nResp = Base.length(resp)

        # Calculate standard error of response
        seResp = sdResp ./ Base.sqrt.(nResp)

        # Calculate Pearson residuals
        PearsResids = (resids ./ seResp) ./ 10

        ###################################################
        # - Calculate hat matrix 
        ###################################################

        # Extract model formula 
        mod_formula = StatsModels.formula(model)

        # Calculate hat matrix
        reg = LinRegOutliers.createRegressionSetting(mod_formula, df)
        hat = LinRegOutliers.hatmatrix(reg)

        ###################################################
        # - Standardise Pearson residuals
        ###################################################

        # Extract deviance and residual df
        modDeviance = GLM.deviance(model)
        modResidualDf = GLM.dof_residual(model)

        # Calculate 's'
        s = Base.sqrt.(modDeviance ./ modResidualDf)

        # Standardise residuals by hat matrix 
        # - Same as R: resid(mod1, type="deviance")/sqrt(1 - hatvalues(mod1))
        # - Necessary when dispersion parameter not equal to 1 
        dHat = LinearAlgebra.Diagonal(hat)
        StdPearsResids = PearsResids ./ (s .* (Base.sqrt.(1 .- dHat)) )
        StdPearsResids = StdPearsResids[:,1]

        # Calculate square root of Std. Pearson residuals 
        sqrPearResids = sqrt.(complex(StdPearsResids))
        sqrPearResids = abs.(sqrPearResids)

        # Define quantiles
        qx = Distributions.quantile.(Distributions.Normal(),
                                        Base.range(0.5,
                                                  stop = (nResp .- 0.5),
                                                  length = (nResp)) ./ (nResp .+ 1))

        ###################################################
        # - Plot scale-location plot
        ###################################################

        p = Gadfly.plot(
            # Add points layer
            x = pred,
            y = sqrPearResids,
            Gadfly.layer(Gadfly.Geom.point),
            Gadfly.layer(Gadfly.Geom.smooth(method = :loess,
                                            smoothing = 0.9)),
            # Change plot aesthetics
            Gadfly.Guide.title("Scale-Location"),
            Gadfly.Guide.xlabel("Predicted values",
                                orientation=:horizontal),
            Gadfly.Guide.ylabel("√ Std. Pearson residuals"))

        # Return the plot object
        return(p)

    # Calculate and plot Standardised deviance residuals if model was
    # fit with a non-Gaussian distribution 
    else 

        ###################################################
        # - Calculate raw deviance residuals 
        ###################################################

        # Use if-elseif-else statements to calculate deviance residuals depending
        # on which error distribution was specified during model specification 

        # Extract fitted/predicted values from model object
        pred = GLM.predict(model)

        # Calculate raw deviance residuals 
        devResids = ModelCheck.calc_deviance_resids(model = model, 
                                                    df = df, 
                                                    y = y)

        # Calculate length (n) of residuals vector
        nResids = Base.length(devResids)

        ###################################################
        # - Calculate hat matrix 
        ###################################################

        # Extract model formula 
        mod_formula = StatsModels.formula(model)

        # Calculate hat matrix
        reg = LinRegOutliers.createRegressionSetting(mod_formula, df)
        hat = LinRegOutliers.hatmatrix(reg)

        ###################################################
        # - Standardise deviance residuals 
        ###################################################

        # Extract deviance and residual df
        modDeviance = GLM.deviance(model)
        modResidualDf = GLM.dof_residual(model)

        # Calculate 's'
        s = Base.sqrt.(modDeviance ./ modResidualDf)

        # Standard residuals by hat matrix 
        # - Same as R: resid(mod1, type="deviance")/sqrt(1 - hatvalues(mod1))
        # - Necessary when dispersion parameter not equal to 1 
        dHat = LinearAlgebra.Diagonal(hat)
        StdDevResids = devResids ./ (s * (Base.sqrt.(1 .- dHat)) )
        StdDevResids = StdDevResids[:,1] 

        # Calculate square root of Std. deviance residuals 
        sqrDevResids = sqrt.(complex(StdDevResids))
        sqrDevResids = abs.(sqrDevResids)

        # Define quantiles
        qx = Distributions.quantile.(Distributions.Normal(),
                                        Base.range(0.5,
                                        stop = (nResids .- 0.5),
                                        length = (nResids))    
                                    ./ (nResids .+ 1))
                            
         ###################################################
        # - Plot scale-location plot
        ###################################################

        p = Gadfly.plot(
            # Add points layer
            x = pred,
            y = sqrDevResids,
            Gadfly.layer(Gadfly.Geom.point),
            Gadfly.layer(Gadfly.Geom.smooth(method = :loess,
                                            smoothing = 0.9)),
            # Change plot aesthetics
            Gadfly.Guide.title("Scale-Location"),
            Gadfly.Guide.xlabel("Predicted values",
                                orientation=:horizontal),
            Gadfly.Guide.ylabel("√ Std. deviance residuals"))

        # Return the plot object
        return(p)

    end # End the if-else statement for Pearson vs Deviance residual plot
end     # End the entire function