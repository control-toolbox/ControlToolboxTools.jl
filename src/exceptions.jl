# --------------------------------------------------------------------------------------------------
# General abstract type for exceptions
abstract type ControlToolboxException <: Exception end

# ambiguous description
struct AmbiguousDescription <: ControlToolboxException
    var::Description
end

"""
	Base.showerror(io::IO, e::AmbiguousDescription)

TBW
"""
Base.showerror(io::IO, e::AmbiguousDescription) = print(io, "the description ", e.var, " is ambiguous / incorrect")

# inconsistent argument
struct InconsistentArgument <: ControlToolboxException
    var::String
end

"""
	Base.showerror(io::IO, e::InconsistentArgument)

TBW
"""
Base.showerror(io::IO, e::InconsistentArgument) = print(io, e.var)

# incorrect method
struct IncorrectMethod <: ControlToolboxException
    var::Symbol
end

"""
	Base.showerror(io::IO, e::IncorrectMethod)

TBW
"""
Base.showerror(io::IO, e::IncorrectMethod) = print(io, e.var, " is not an existing method")