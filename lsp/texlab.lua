return {
    settings = {
        texlab = {
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
            },
            forwardSearch = {
                executable = "SumatraPDF",
                args = { "-reuse-instance", "-forward-search", "%f", "%l", "%p" },
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = true,
            },
        },
    },
}
