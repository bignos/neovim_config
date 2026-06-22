return {
	{
		"EdenEast/nightfox.nvim",
        enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false,
					terminal_colors = true,
					dim_inactive = false,
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "bold",
					},
				},
				palettes = {
					duskfox = {
						bg0 = "#1b1d2b",
						bg1 = "#161822",
						bg3 = "#2a2f42",
						sel0 = "#31364c",
					},
				},
			})
			vim.cmd.colorscheme("duskfox")
		end,
	},
}
