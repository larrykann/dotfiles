return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua LSP
      lspconfig.lua_ls.setup {}

      -- C LSP
      lspconfig.clangd.setup {
        cmd = {
          "clangd"
        },
      }

      -- Zig
      lspconfig.zls.setup {}
    end,
  }
}
