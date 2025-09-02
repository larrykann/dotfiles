return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        -- no snippet engine: keep a no-op expand to satisfy cmp
        snippet = { expand = function(_) end },

        mapping = cmp.mapping.preset.insert({
          ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- Enter confirms selection
          ["<C-Space>"] = cmp.mapping.complete(),                 -- manual trigger (optional)
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },

        experimental = { ghost_text = true },
      })
    end,
  },
}
