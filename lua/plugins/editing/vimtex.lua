return {
    "lervag/vimtex",
    lazy = true,
    ft = "tex",
    init = function()
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_general_viewer = "SumatraPDF"
        vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
        vim.g.vimtex_compiler_latexmk = {
            build_dir = "",
            continuous = 1,
            callback = 1,
        }
    end,
}
