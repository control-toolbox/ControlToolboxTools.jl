using ControlToolboxTools
using Test

# functions and types that are not exported
const get_priority_print_callbacks = ControlToolboxTools.get_priority_print_callbacks
const get_priority_stop_callbacks = ControlToolboxTools.get_priority_stop_callbacks

# tests
@testset verbose = true showtiming = true "ControlToolboxTools" begin
    for name in (
        "exceptions",
        "callbacks",
        "descriptions",
        "macros",
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end
