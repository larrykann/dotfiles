-- Keep the cursor in the middle of the screen when scrolling.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Better navigation when searching for regex.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- For copying to the clipboard.
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Select all and yank to clipboard.
vim.keymap.set("n", "<leader>Y", "ggVG\"+Y")

-- Quickly replace all instances of a word.
vim.keymap.set("n", "<leader>rw", ":%s/")
