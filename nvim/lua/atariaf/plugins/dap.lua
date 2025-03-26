return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configure DAP signs
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'DapStopped' })

      -- Setup DAP UI with minimal configuration
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
      })

      -- Configure codelldb adapter
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- This will be available when mason-nvim-dap installs it
          command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
          args = { "--port", "${port}" },
        }
      }

      -- Configure C debugging with both realtest and generic options
      dap.configurations.c = {
        {
          name = "Attach to realtest",
          type = "codelldb",
          request = "attach",
          pid = function()
            local handle = io.popen('tasklist /FI "IMAGENAME eq realtest.exe" /FO CSV /NH')
            if not handle then
              vim.notify("Failed to run tasklist command", vim.log.levels.ERROR)
              return nil
            end

            local output = handle:read("*a")
            handle:close()

            -- Extract PID
            local pid_match = output:match('"realtest.exe","(%d+)"')
            if pid_match then
              return tonumber(pid_match)
            else
              vim.notify("realtest.exe not found running. Please start it first.", vim.log.levels.ERROR)
              return nil
            end
          end,
          args = {},
          cwd = '${workspaceFolder}',
        },
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        }
      }
      -- Configure C++ debugging (same as C but for .cpp files)
      dap.configurations.cpp = dap.configurations.c

      -- DAP UI integration
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end,          desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end,         desc = "Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle DAP UI" },
      { "<leader>dx", function() require("dap").terminate() end,         desc = "Terminate" },
      {
        "<leader>drt",
        function()
          local dap = require("dap")
          -- Auto-select the realtest configuration
          local configs = dap.configurations.c
          for _, config in ipairs(configs) do
            if config.name == "Attach to realtest" then
              dap.run(config)
              return
            end
          end
        end,
        desc = "Debug realtest"
      },
    },
  }
}
