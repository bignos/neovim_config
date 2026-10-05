return {
	{
		"neovim/nvim-lspconfig",
		enabled = true,

		dependencies = {
			-- LSP Support
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
		},

		config = function()
			-- Completion
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)
			require("fidget").setup({})

			require("mason").setup()

			-- 1. On définit les configurations spécifiques pour nos serveurs Python
			-- Avec la nouvelle API, on passe par vim.lsp.config
			if vim.lsp.config then
				-- Configuration moderne pour Ruff
				vim.lsp.config("ruff", {
					init_options = {
						settings = {
							format = { enable = false }, -- Black s'occupe du format
						},
					},
				})

				-- Configuration moderne pour Pylsp
				vim.lsp.config("pylsp", {
					settings = {
						pylsp = {
							plugins = {
								pyflakes = { enabled = false },
								mccabe = { enabled = false },
								pycodestyle = { enabled = false },
								flake8 = { enabled = false },
								yapf = { enabled = false },
								autopep8 = { enabled = false },
								rope_completion = { enabled = true },
								rope_autoimport = { enabled = true },
								rope_plugin = { enabled = true },
							},
							rope = {
								ropeFolder = { nil },
							},
						},
					},
				})

				-- Configuration Externe ruby-lsp
				vim.lsp.config("ruby_lsp", {
					cmd = { "bundle", "exec", "ruby-lsp" },
					root_markers = { "Gemfile", ".git" },
				})

                vim.lsp.enable("ruby_lsp")
			else
				-- Fallback pour la compatibilité si ta version de Neovim n'a pas encore vim.lsp.config
				local configs = require("lspconfig.configs")
				if configs.ruff then
					configs.ruff.setup = function() end
				end
				if configs.pylsp then
					configs.pylsp.setup = function() end
				end
			end

			-- 2. Capabilities communes à tous les serveurs (API v2 : handlers n'existe plus)
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- 3. On lance mason-lspconfig, qui active automatiquement tout serveur installé via Mason
			require("mason-lspconfig").setup()

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				-- formatting = cmp_format,
				preselect = "item",
				completion = {
					autocomplete = false, -- No toggle auto the completion menu
				},
				window = {
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<cr>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer", keyword_length = 3 },
				}),

				cmp.setup.filetype("lua", {
					sources = cmp.config.sources({
						{ name = "nvim_lua" },
					}, {
						{ name = "buffer", keyword_length = 3 },
					}),
				}),

				cmp.setup.filetype("norg", {
					sources = cmp.config.sources({
						{ name = "neorg" },
					}, {
						{ name = "buffer", keyword_length = 3 },
					}),
				}),

				cmp.setup.filetype("sql", {
					sources = cmp.config.sources({
						{ name = "vim-dadbod-completion" },
					}, {
						{ name = "buffer", keyword_length = 3 },
					}),
				}),
			})

			local icons = require("nvim-web-devicons")

			local severity_icons = {
				[vim.diagnostic.severity.ERROR] = icons.get_icon_by_filetype("log", { default = true }),
				[vim.diagnostic.severity.WARN] = icons.get_icon_by_filetype("conf", { default = true }),
				[vim.diagnostic.severity.HINT] = icons.get_icon_by_filetype("md", { default = true }),
				[vim.diagnostic.severity.INFO] = icons.get_icon_by_filetype("json", { default = true }),
			}

			vim.diagnostic.config({
				signs = {
					active = true,
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Affichage auto du diagnostic au survol curseur (scope local à lspconfig.lua)
			vim.o.updatetime = 1500
			local diag_float_group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold" }, {
				group = diag_float_group,
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
				end,
			})

			vim.keymap.set("n", "<leader>Um", function()
				vim.cmd("Mason")
			end, { desc = "Mason" })

			vim.keymap.set("n", "gd", function()
				Snacks.picker.lsp_definitions()
			end, { desc = "Goto definition LSP" })
			vim.keymap.set("n", "gD", function()
				Snacks.picker.lsp_declarations()
			end, { desc = "Goto declaration" })
			vim.keymap.set("n", "gh", function()
				vim.lsp.buf.hover()
			end, { desc = "Hover" })
			vim.keymap.set("n", "gr", function()
				Snacks.picker.lsp_references()
			end, { desc = "References" })
			vim.keymap.set("n", "gI", function()
				Snacks.picker.lsp_implementations()
			end, { desc = "Goto implementation" })
			vim.keymap.set("n", "gj", function()
				Snacks.picker.lsp_type_definitions()
			end, { desc = "Goto type definition" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, { desc = "Next diagnostic" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, { desc = "Prev diagnostic" })
			vim.keymap.set("n", "<leader>CA", function()
				vim.lsp.buf.code_action()
			end, { desc = "Code Action" })
			vim.keymap.set({ "n", "x" }, "<leader>R", function()
				vim.lsp.buf.code_action({
					context = {
						only = { "refactor" },
					},
				})
			end, { desc = "LSP Refactor Actions" })
			vim.keymap.set("n", "<leader>Cr", function()
				vim.lsp.buf.references()
			end, { desc = "References" })
			vim.keymap.set("n", "<leader>CR", function()
				vim.lsp.buf.rename()
			end, { desc = "Rename" })
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, { desc = "Signature help" })
		end,
	},
}
