using Documenter
using ModelCheck

makedocs(
    sitename = "ModelCheck",
    format = Documenter.HTML(),
    modules = [ModelCheck]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
