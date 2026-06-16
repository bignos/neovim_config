return {
	{
		"nickjvandyke/opencode.nvim",
		enabled = true,
		version = "*", -- Latest stable release
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any; goto definition on the type or field for details
			}

			vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`
			-- require("snacks").setup({
			-- 	input = {
			-- 		enabled = true, -- Enhances `ask()`
			-- 	},
			-- 	picker = {
			-- 		enabled = true, -- Enhances `select()`
			-- 		actions = {
			-- 			---@param picker snacks.Picker
			-- 			opencode_send = function(picker)
			-- 				local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
			-- 					return item.file
			-- 							and require("opencode").format({
			-- 								path = item.file,
			-- 								from = item.pos,
			-- 								to = item.end_pos,
			-- 							})
			-- 						or item.text
			-- 				end, picker:selected({ fallback = true }))
			--
			-- 				require("opencode").prompt(table.concat(items, ", ") .. " ")
			-- 			end,
			-- 		},
			-- 		win = {
			-- 			input = {
			-- 				keys = {
			-- 					["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
		end,
		keys = {
			{ "<leader>Oa", function() require("opencode").ask("@this: ") end, desc = "Ask OpenCode", mode = { "n", "x" } },
			{ "<leader>Os", function() require("opencode").select() end, desc = "Select OpenCode", mode = { "n", "x" } },
			{ "gO", function() return require("opencode").operator("@this ") end, desc = "Append range to OpenCode", mode = { "n", "x" } },
			{ "gOo", function() return require("opencode").operator("@this ") .. "_" end, desc = "Append line to OpenCode", mode = "n" },
		},
	},
}
