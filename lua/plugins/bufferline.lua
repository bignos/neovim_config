return {
    {
        "akinsho/bufferline.nvim",
        event = "BufAdd",
        dependencies =  { "nvim-tree/nvim-web-devicons", opt = true },
        init = function()
            require("bufferline").setup{}
        end
    }
}
