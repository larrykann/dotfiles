return {
  "folke/zen-mode.nvim",
  ft = { "markdown" },
  keys = {
    { "<leader>z", function() require("zen-mode").toggle() end, desc = "Zen 80 (Markdown)" },
  },
  opts = {
    window = {
      width = 80,
      options = {
        wrap = true,
        linebreak = true,
        breakindent = true,
      },
    },
  },
}
