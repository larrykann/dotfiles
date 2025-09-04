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

      -- buffer-local LSP setup (completion + nav)
      local on_attach = function(_, bufnr)
        -- basic LSP keys
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "Find references")
        map("K", vim.lsp.buf.hover, "Hover")
      end


      -- Lua LSP
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- C LSP
      lspconfig.clangd.setup {
        on_attach = on_attach,
        cmd = { "clangd" },
        capabilities = capabilities,
      }

      -- Zig
      lspconfig.zls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- Markdown (Marksman)
      lspconfig.marksman.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
      }
    end,
  }
}
