-- Force le chargement de plenary pour éviter que lazy-rocks/neorg ne casse les chemins d'accès
pcall(require, "plenary")
return {
	{
		"ThePrimeagen/refactoring.nvim",
        enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		config = function()
			require("refactoring").setup({
				-- prompt for return type
				prompt_func_return_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
					python = true,
					javascript = true,
					ruby = true,
				},
				-- prompt for function parameters
				prompt_func_param_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
					python = true,
					javascript = true,
					ruby = true,
				},
			})

			-- Remaps for the refactoring operations currently offered by the plugin
			vim.keymap.set({ "n", "x" }, "<leader>Rf", function()
				return require("refactoring").refactor("Extract Function")
			end, { desc = "Extract Function" })
			vim.keymap.set({ "n", "x" }, "<leader>RF", function()
				return require("refactoring").refactor("Extract Function To File")
			end, { desc = "Extract Function To File" })
			vim.keymap.set({ "n", "x" }, "<leader>Rv", function()
				return require("refactoring").refactor("Extract Variable")
			end, { desc = "Extract Variable" })
			vim.keymap.set({ "n", "x" }, "<leader>Ri", function()
				return require("refactoring").refactor("Inline Function")
			end, { desc = "Inline Function" })
			vim.keymap.set({ "n", "x" }, "<leader>RI", function()
				return require("refactoring").refactor("Inline Variable")
			end, { desc = "Inline Variable" })

			vim.keymap.set({ "n", "x" }, "<leader>Rb", function()
				return require("refactoring").refactor("Extract Block")
			end, { desc = "Extract Block" })
			vim.keymap.set({ "n", "x" }, "<leader>RB", function()
				return require("refactoring").refactor("Extract Block To File")
			end, { desc = "Extract Block To File" })
		end,
	},
}
