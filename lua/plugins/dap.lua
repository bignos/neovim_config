return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            require("dapui").setup()
        end,
        keys = {
            {
                "<leader>Db",
                function() require("dap").toggle_breakpoint() end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>DB",
                function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                desc = "Set Conditional Breakpoint",
            },
            {
                "<leader>Dc",
                function() require("dap").continue() end,
                desc = "Continue",
            },
            {
                "<leader>Dq",
                function() require("dap").close() end,
                desc = "Close",
            },
            {
                "<leader>Di",
                function() require("dap").step_into() end,
                desc = "Step Into",
            },
            {
                "<leader>DO",
                function() require("dap").step_over() end,
                desc = "Step Over",
            },
            {
                "<leader>Do",
                function() require("dap").step_out() end,
                desc = "Step Out",
            },
            {
                "<leader>Dr",
                function() require("dap").repl.open() end,
                desc = "Repl",
            },
            {
                "<leader>Dl",
                function() require("dap").run_last() end,
                desc = "Run Last",
            },
            {
                "<leader>Dt",
                function() require("dapui").toggle() end,
                desc = "Toggle UI",
            },
        },
    },
}
