# ModelCheck

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://guysutton.github.io/ModelCheck.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://guysutton.github.io/ModelCheck.jl/dev)
[![Build Status](https://github.com/guysutton/ModelCheck.jl/workflows/CI/badge.svg)](https://github.com/guysutton/ModelCheck.jl/actions)
[![Coverage](https://codecov.io/gh/guysutton/ModelCheck.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/guysutton/ModelCheck.jl)

`ModelCheck.jl` is a `Julia` package designed to perform model diagnostics for fitted General Linear Models (GLM's). Currently GLM's specificed using `GLM.jl` are supported. 

## 1. Installation

`ModelCheck.jl` is currently unregistered, so it must be installed from GitHub directly, by entering the package manager (by typing `]` into the `Julia` REPL) and then specifying the source URL to this repository:

```julia-repl
julia> ]
julia> add https://github.com/guysutton/ModelCheck.jl
```