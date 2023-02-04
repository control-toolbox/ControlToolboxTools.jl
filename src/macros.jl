# exception thrower
function throw_callable_error( msg = nothing )
    if isnothing(msg)
        throw(error("@callable input is incorrect, expected: struct MyStruct end"))
    else
        throw(error("@callable input is incorrect: ", msg))
    end
end

macro callable(expr)

#=     @show(expr)
    println("---")
    println(expr)
    println("---")
    println(typeof(expr))
    println("---")
    println(Meta.show_sexpr(expr))
    println("---")
    println(expr.head)
    println("---")
    println(expr.args)
    println("==================================================") =#

    # first elements must be :struc
    if !hasproperty(expr, :head) || expr.head != Symbol(:struct)
        return :(throw_callable_error())
    end

    #
    MyStruct = expr.args[2]
    esc(quote
        struct $MyStruct
            f::Function
        end
        (s::$MyStruct)(args...; kwargs...) = s.f(args...; kwargs...)
    end)
end
