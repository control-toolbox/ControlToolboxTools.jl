using CTDescriptions
using Test

@testset verbose = true showtiming = true "CTDescriptions" begin
    for name in (
        "exceptions",
        "utils"
        )
        @testset "$name" begin
            include("test_$name.jl")
        end
    end
end
