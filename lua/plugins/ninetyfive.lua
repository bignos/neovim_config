return {
    {
        "numerataz/ninetyfive.nvim",
        enabeld = true,
        config = function()
            require("ninetyfive").setup({
                enable_on_startup = false,
                use_cmp = false,

                mappings = {
                    accept = "<C-g>",
                    reject = "<C-x>",
                    accept_word = "",
                    accept_line = "",
                },

                indexing = {
                    mode = "off",
                },
            })
        end,
        keys = {
            {
                "<leader>Ys",
                "<cmd>NinetyFiveToggle<cr>",
                desc = "Toggle NinetyFive",
            },
        },
    },
}
