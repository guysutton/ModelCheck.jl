# Write function to automate plotting combined diagnostics plots
# - Plots all three standard plots for assessing linear model fits

function plot_model_check(;model, df, y)

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

    # Set default plot size
    Gadfly.set_default_plot_size(24Gadfly.cm, 12Gadfly.cm)

    # Make individual diagnostics plots
    # - These plots are the equivalent of calling plot(...) on a
    #   linear model (e.g. lm, ANOVA) in R. 
    p1 = ModelCheck.plot_qqplot(model = model, df = df, y = y)
    p2 = ModelCheck.plot_residual_fitted(model = model, df = df, y = y)
    p3 = ModelCheck.plot_scale_location(model = model, df = df, y = y)

    # Plot all three plots in a single graph
    all_plots = Gadfly.hstack(p1, p2, p3)

    # Return plots
    return(all_plots)

end