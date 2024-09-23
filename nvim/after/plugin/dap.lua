require("dap-python").setup("C:/Users/kannd/.conda/envs/quantTools/python.exe")

local dap, dapui = require("dap"), require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Keymaps
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")

vim.keymap.set("n", "<leader>dp",
    function()
        require('dap-python').test_method()
    end
)
