return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			preview = {
				filetype = { "markdown", "codecompanion" },
				ignore_buftypes = {},
			},
		},
		keys = {
			{
				"<leader>Ym",
				function()
					vim.cmd("Markview toggle")
				end,
				desc = "Markdown view toggle",
			},
		},
	},
}
