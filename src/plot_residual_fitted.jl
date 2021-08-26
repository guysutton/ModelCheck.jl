# Write function to automate plotting residual vs fitted plot
# - Plots standard residual vs fitted plot for assessing linear model fits

function plot_residual_fitted(;model, df, y)

    # Uses an if-else statement to either plot Pearson residuals
    # if the model is fit with a Gaussian/Normal distribution, or 
    # deviance residuals if the model is fit with an 
    # exponential family (e.g. Poisson) or any non-Gaussian data distribution.

    ###################################################
    # - Setup and defaults
    ###################################################

    # Set Gadfly theme  
    default_theme = Gadfly.Theme(
        panel_fill = nothing,
        highlight_width = 0Gadfly.pt,
        point_size = 0.8Gadfly.mm,
        key_position = :inside,
        #grid_line_width = [0 Measures.mm],
        panel_stroke = Colors.colorant"black",
        background_color = Colors.colorant"white")
    Gadfly.push_theme(default_theme)

    ###################################################
    # - Plot either Pearson or deviance residuals
    ###################################################

    # Extract statistical distribution specified in model 
    distType = typeof(model).parameters[1].parameters[1].parameters[2]
    distType = string.(distType)

    # Calculate and plot Pearson Residuals if model was
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
        PearsResids = resp .- pred

        # Calculate standard deviation of observed value
        sdResp = Statistics.std(resp)

        # Calculate length (n) of response vector
        nResp = Base.length(resp)

        # Calculate standard error of response
        #seResp = sdResp ./ Base.sqrt.(nResp)

        # Calculate Pearson residuals
        #PearsResids = (resids ./ seResp) ./ 10

        ###################################################
        # - Plot residual vs fitted plot
        ###################################################

        # Create plot
        p = Gadfly.plot(
            # Add points layer
            x = pred,
            y = PearsResids,
            Gadfly.layer(Gadfly.Geom.smooth(method = :loess,
                                    smoothing = 0.9),
                                    color=[Colors.colorant"red"]),
            Gadfly.layer(Gadfly.Geom.point),
            # Add horizontal y = 0 line
            Gadfly.layer(yintercept = [0],
            Gadfly.Geom.hline(style = :dash)),
            # Change plot aesthetics   
            Gadfly.Scale.x_continuous(format=:plain),
            Gadfly.Scale.y_continuous(format=:plain),
            Gadfly.Guide.xlabel("Fitted values", orientation=:horizontal),
            Gadfly.Guide.ylabel("Pearson residuals"),
            Gadfly.Guide.title("Residuals vs Fitted"))

        # Return the plot object
        return(p)

    # Calculate and plot deviance residuals if model was
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
    
        ###################################################
        # - Plot residual vs fitted plot
        ###################################################

        # Create plot
        p = Gadfly.plot(
            # Add points layer
            x = pred,
            y = devResids,
            Gadfly.layer(Gadfly.Geom.smooth(method = :loess,
                                    smoothing = 0.9),
                                    color=[Colors.colorant"red"]),
            Gadfly.layer(Gadfly.Geom.point),
            # Add horizontal y = 0 line
            Gadfly.layer(yintercept = [0],
            Gadfly.Geom.hline(style = :dash)),
            # Change plot aesthetics
            Gadfly.Scale.x_continuous(format=:plain),
            Gadfly.Scale.y_continuous(format=:plain),
            Gadfly.Guide.xlabel("Fitted values", orientation=:horizontal),
            Gadfly.Guide.ylabel("Deviance residuals"),
            Gadfly.Guide.title("Residuals vs Fitted"))

        # Return the plot object
        return(p)

    end # End the if-else statement for Pearson vs Deviance residual plot
end     # End the entire function