module ControlToolboxTools

import Base: \, Base

# -------------------------------------------------------------------------------------------------- 
# A desription is a tuple of symbols
const DescVarArg = Vararg{Symbol} # or Symbol...
const Description = Tuple{DescVarArg}

#
include("./exceptions.jl")
include("./descriptions.jl")
include("./callbacks.jl")
include("./macros.jl")
include("functions.jl")

# description
export Description, makeDescription, add, getFullDescription

# exceptions
export ControlToolboxException, AmbiguousDescription, InconsistentArgument, IncorrectMethod

# callbacks
export ControlToolboxCallback, PrintCallback, StopCallback
export get_priority_print_callbacks, get_priority_stop_callbacks

# macros
export @callable, @time_dependence_function

# functions
export Hamiltonian, HamiltonianVectorField, VectorField
export LagrangeFunction, DynamicsFunction, ControlFunction, MultiplierFunction
export StateConstraintFunction, ControlConstraintFunction, MixedConstraintFunction

end # module ControlToolboxTools
