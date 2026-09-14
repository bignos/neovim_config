return {
	{
		"supermaven-inc/supermaven-nvim",
        enabled = true,
		config = function()
			require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<C-g>",
                    clear_suggestion = "<C-x>"
                },

            })
            -- Utiliser pour desactiver SuperMaven par defaut
            local api = require("supermaven-nvim.api")
            if api.is_running() then
                api.stop()
            end
		end,
        keys = {
            {
                "<leader>Ys",
                "<cmd>SupermavenToggle<cr>",
                desc = "Toggle SuperMaven"
            }
        }

	},
}
