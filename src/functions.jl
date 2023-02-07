abstract type AbstractControlFunction{time_dependence} end

struct ControlFunction{time_dependence}
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