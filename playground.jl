using ModelCheck

# Check qqplot works 
ModelCheck.plot_qq(model = modPoisson, df = df, y = "y")