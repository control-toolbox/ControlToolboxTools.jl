# exception thrower
function throw_callable_error( msg = nothing )
    if isnothing(msg)
        throw(error("@callable input is incorrect, expected a struct"))
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

    #println(expr.args[3])

    #
    corps = expr.args[3]
    MyStruct = expr.args[2]
    fun = gensym("fun")
    esc(quote
        struct $MyStruct{f}
            $fun::Function
            $corps
            function $MyStruct{f}(args...) where {f}
                new{f}(f, args...)
            end
            function $MyStruct(f::Function, args...)
                $MyStruct{f}(args...)
            end
            function $MyStruct(args...; f::Function)
                $MyStruct{f}(args...)
            end
        end
        (s::$MyStruct)(args...; kwargs...) = s.$fun(args...; kwargs...)
    end)
end
