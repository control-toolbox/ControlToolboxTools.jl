using Documenter
using CTDescriptions

makedocs(
    sitename = "CTDescriptions.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/CTDescriptions.jl.git",
    devbranch = "main"
)
