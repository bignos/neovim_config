vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		local parsers = require("nvim-treesitter.parsers")

		parsers.asciidoc = {
			install_info = {
				url = "https://github.com/cathaysia/tree-sitter-asciidoc",
				branch = "master",
				location = "tree-sitter-asciidoc",
				queries = "queries/asciidoc/",
			},
			tier = 2,
		}

		parsers.asciidoc_inline = {
			install_info = {
				url = "https://github.com/cathaysia/tree-sitter-asciidoc",
				branch = "master",
				location = "tree-sitter-asciidoc_inline",
				queries = "queries/asciidoc_inline/",
			},
			tier = 2,
		}
	end,
})
