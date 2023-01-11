using Documenter
using ControlToolboxTools

makedocs(
    sitename = "ControlToolboxTools.jl",
    format = Documenter.HTML(prettyurls = false),
    pages = [
        "Introduction" => "index.md",
        "API" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/control-toolbox/ControlToolboxTools.jl.git",
    devbranch = "main"
)
