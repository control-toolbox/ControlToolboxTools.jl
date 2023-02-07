abstract type AbstractControlFunction{T, time_dependence} end

struct ControlFunction{time_dependence} <: AbstractControlFunction{Any, time_dependence}
    f::Function
    function ControlFunction{time_dependence}(f::Function) where {time_dependence}
        if !(time_dependence ∈ [:autonomous, :nonautonomous])
            error("the function must be :autonomous or :nonautonomous")
        else
            new{time_dependence}(f)
        end
    end
    ControlFunction(f::Function) = new{:autonomous}(f)
end
function (F::ControlFunction{time_dependence})(t, args...; kwargs...) where {time_dependence}
    return time_dependence==:autonomous ? F.f(args...; kwargs...) : F.f(t, args...; kwargs...)
end

#
abstract type AbstractHamiltonian end
abstract type AbstractHamiltonianVectorField end
abstract type AbstractVectorField end

#
struct Hamiltonian{time_dependence} <: AbstractControlFunction{AbstractHamiltonian, time_dependence}
    f::Function
    function Hamiltonian{time_dependence}(f::Function) where {time_dependence}
        if !(time_dependence ∈ [:autonomous, :nonautonomous])
            error("the function must be :autonomous or :nonautonomous")
        else
            new{time_dependence}(f)
        end
    end
    Hamiltonian(f::Function) = new{:autonomous}(f)
end
function (F::Hamiltonian{time_dependence})(t, args...; kwargs...) where {time_dependence}
    return time_dependence==:autonomous ? F.f(args...; kwargs...) : F.f(t, args...; kwargs...)
end

#
struct HamiltonianVectorField{time_dependence} <: AbstractControlFunction{AbstractHamiltonianVectorField, time_dependence}
    f::Function
    function HamiltonianVectorField{time_dependence}(f::Function) where {time_dependence}
        if !(time_dependence ∈ [:autonomous, :nonautonomous])
            error("the function must be :autonomous or :nonautonomous")
        else
            new{time_dependence}(f)
        end
    end
    HamiltonianVectorField(f::Function) = new{:autonomous}(f)
end
function (F::HamiltonianVectorField{time_dependence})(t, args...; kwargs...) where {time_dependence}
    return time_dependence==:autonomous ? F.f(args...; kwargs...) : F.f(t, args...; kwargs...)
end

#
struct VectorField{time_dependence} <: AbstractControlFunction{AbstractVectorField, time_dependence}
    f::Function
    function VectorField{time_dependence}(f::Function) where {time_dependence}
        if !(time_dependence ∈ [:autonomous, :nonautonomous])
            error("the function must be :autonomous or :nonautonomous")
        else
            new{time_dependence}(f)
        end
    end
    VectorField(f::Function) = new{:autonomous}(f)
end
function (F::VectorField{time_dependence})(t, args...; kwargs...) where {time_dependence}
    return time_dependence==:autonomous ? F.f(args...; kwargs...) : F.f(t, args...; kwargs...)
end