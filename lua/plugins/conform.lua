return {
	{
		"stevearc/conform.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				format_on_save = false,
				formatters_by_ft = {
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					javascript = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					eruby = { "erb_format" },
					lua = { "stylua" },
					ruby = { "syntax_tree" },
					python = { "black" },
					go = { "gofumpt", "goimports" },
				},

                formatters = {
					syntax_tree = {
						append_args = {
							"--plugins=plugin/single_quotes",
						},
					},
				},
			})
		end,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({
						async = true,
						lsp_format = "fallback",
					})
				end,
				desc = "Format buffer",
			},
		},
	},
}
