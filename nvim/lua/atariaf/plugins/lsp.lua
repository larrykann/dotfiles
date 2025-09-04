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

      -- cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Lua LSP
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }

      -- C LSP
      lspconfig.clangd.setup {
        cmd = { "clangd" },
        capabilities = capabilities,
      }

      -- Zig
      lspconfig.zls.setup {
        capabilities = capabilities,
      }

      -- Markdown (Marksman)
      lspconfig.marksman.setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
      }
    end,
  }
}
