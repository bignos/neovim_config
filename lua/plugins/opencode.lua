return {
	{
		"sudo-tee/opencode.nvim",
		enabled = true,
		config = function()
			require("opencode").setup({
                keymap_prefix = '<leader>O',
            })
		end,
		dependencies = {
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					anti_conceal = { enabled = false },
					file_types = { "markdown", "opencode_output" },
				},
				ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
			},
			-- Optional, for file mentions and commands completion, pick only one
			'hrsh7th/nvim-cmp',

			-- Optional, for file mentions picker, pick only one
			"folke/snacks.nvim",
		},
	},
}
