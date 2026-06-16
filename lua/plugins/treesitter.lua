return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        ---@type TSConfig
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            additional_vim_regex_highlighting = false,
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {},
            auto_install = true,
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    }
}
