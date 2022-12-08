using Documenter
using Descriptions

makedocs(
    sitename = "Descriptions.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/Descriptions.jl.git",
    devbranch = "main"
)
