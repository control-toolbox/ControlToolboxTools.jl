# exception thrower
function throw_callable_error( msg = nothing )
    if isnothing(msg)
        throw(error("@callable input is incorrect, expected a struct"))
    else
        throw(error("@callable input is incorrect: ", msg))
    end
end

macro callable(expr)

#=      @show(expr)
    println("---")
    println(expr)
    println("---")
    println(typeof(expr))
    println("---")
    println(Meta.show_sexpr(expr))
    println("---")
    println(expr.head)
    println("---")
    println(expr.args[1])
    println("---")
    println(expr.args[2])
    println("---")
    println(expr.args[3])
    println("==================================================") =#

    #dump(expr)

    # first elements must be :struc
    if !hasproperty(expr, :head) || expr.head != Symbol(:struct)
        return :(throw_callable_error())
    end

    #
    corps = expr.args[3]

    # parametric struct or not
    curly=false
    if hasproperty(expr.args[2], :head) && expr.args[2].head == Symbol(:curly)
        struct_name = expr.args[2].args[1]
        struct_params = expr.args[2].args[2:end]
        curly=true
    else
        struct_name = expr.args[2]
        struct_params = ""
    end
    #println(struct_name)
    #println(struct_params)

    fun = gensym("fun")

    if curly
        esc(quote
            struct $struct_name{$(struct_params...)}
                $fun::Function
                $corps
                #function $struct_name{$(struct_params...)}(caller::Function, args...) where {$(struct_params...)}
                #    new{$(struct_params...)}(caller, args...)
                #end
                #function $struct_name{$(struct_params...)}(args...; caller::Function) where {$(struct_params...)}
                #    new{$(struct_params...)}(caller, args...)
                #end
            end
            (s::$struct_name{$(struct_params...)})(args...; kwargs...) where {$(struct_params...)} = s.$fun(args...; kwargs...)
        end)
    else
        esc(quote
            struct $struct_name
                $fun::Function
                $corps
                #function $struct_name(caller::Function, args...)
                #    new(caller, args...)
                #end
                #function $struct_name(args...; caller::Function)
                #    new(caller, args...)
                #end
            end
            (s::$struct_name)(args...; kwargs...) = s.$fun(args...; kwargs...)
        end)
    end
end
