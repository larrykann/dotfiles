vim.g.mapleader = " "

vim.opt.guicursor = "n:block,i:block"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir =  os.getenv("HOME") .. "/.config/nvim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Set clipbaord to system clipboard
vim.opt.clipboard = "unnamedplus"

-- Set the background transparency.
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
  end,
})

-- Set the conceal option for Obsidian
vim.opt.conceallevel = 2

-- Word wrap for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
  end
})
