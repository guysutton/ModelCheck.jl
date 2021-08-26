using ModelCheck

# Check qqplot works 
ModelCheck.plot_qqplot(model = modPoisson, df = df, y = "y")

typeof(plot_qqplot(model = modPoisson,
                           df = df,
                           y = "y")) == Plot

# Check residual vs fitted plot works 
ModelCheck.plot_residual_fitted(model = modPoisson, df = df, y = "y")

# Check scale-location plot works 
ModelCheck.plot_scale_location(model = modPoisson, df = df, y = "y")

ModelCheck.plot_model_check(model = modPoisson, df = df, y = "y")