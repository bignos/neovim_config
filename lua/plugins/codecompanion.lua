return {
	{
		"olimorris/codecompanion.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				interactions = {
					chat = { adapter = "gemini" },
					inline = { adapter = "gemini" },
					cmd = { adapter = "gemini" },
				},
				adapters = {
					http = {
						openrouter = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://openrouter.ai/api",
									api_key = os.getenv("OPENAI_API_KEY"),
									chat_url = "/v1/chat/completions",
								},
								schema = { model = { default = "tngtech/deepseek-r1t-chimera:free" } },
							})
						end,
						groq = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://api.groq.com/openai",
									api_key = os.getenv("GROQ_API_KEY"),
									chat_url = "/v1/chat/completions",
								},
								schema = { model = { default = "llama-3.3-70b-versatile" } },
							})
						end,
						cerebras = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://api.cerebras.ai",
									api_key = os.getenv("CEREBRAS_API_KEY"),
									chat_url = "/v1/chat/completions",
								},
								schema = { model = { default = "llama-3.3-70b" } },
							})
						end,
						together = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://api.together.xyz",
									api_key = os.getenv("TOGETHER_API_KEY"),
									chat_url = "/v1/chat/completions",
								},
								schema = { model = { default = "Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8" } },
							})
						end,
						github = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								env = {
									url = "https://models.github.ai/inference",
									api_key = os.getenv("GITHUB_TOKEN"),
								},
								schema = {
									model = {
										default = "gpt-4o",
									},
								},
								opts = {
									headers = {
										["User-Agent"] = "CodeCompanion",
										["x-github-api-version"] = "2022-11-28",
									},
								},
							})
						end,
						gemini = function()
							return require("codecompanion.adapters").extend("gemini", {
								env = {
									api_key = os.getenv("GEMINI_API_KEY"),
								},
								schema = {
									model = {
										default = "gemini-2.5-flash",
									},
								},
							})
						end,
					},
				},
				display = {
					action_palette = { provider = "snacks" },
					chat = {
						show_settings = true,
						render_headers = true,
					},
				},
			}) -- Fermeture propre du setup
		end,
		keys = {
			{ "<leader>c", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion", mode = "n" },
			{ "<leader>q", ":CodeCompanion<cr>", desc = "Question Code Companion", mode = "x" },
			{ "<leader>Cq", ":CodeCompanionAction<cr>", desc = "Code Companion Action", mode = "n" },
		},
	},
}
