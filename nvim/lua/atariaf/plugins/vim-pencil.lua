return {
  {
    "reedes/vim-pencil",
    config = function()
      vim.g["pencil#wrapModeDefault"] = "soft"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "text" },
        callback = function()
          vim.cmd([[PencilSoft]])
          vim.opt_local.winwidth = 80
          vim.opt_local.colorcolumn = "80"
        end
      })
    end,
  }
}
