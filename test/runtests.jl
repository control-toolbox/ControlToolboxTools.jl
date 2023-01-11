using ControlToolboxTools
using Test

@testset verbose = true showtiming = true "ControlToolboxTools" begin
    for name in (
        "exceptions",
        "utils"
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end
