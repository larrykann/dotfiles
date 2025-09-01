return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        pickers = {},
        extensions = {
          fzf = {}
        }
      }

      -- Extensions
      -- require('telescope').load_extension('fzf')

      -- Keymaps
      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)

      vim.keymap.set("n", "<space>en", function()
        local opts = require('telescope.themes').get_ivy({
          -- cwd = vim.fn.stdpath("config")
          cwd = "C:/.dotfiles/nvim",
          hidden = true
        })
        require('telescope.builtin').find_files(opts)
      end)

      vim.keymap.set("n", "<space>ep", function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end)

      -- Notes, writing, etc 
      vim.keymap.set("n", "<space>es", function()
        local opts = require('telescope.themes').get_ivy({
          cwd = "~/Documents/scripta"
        })
        require('telescope.builtin').find_files(opts)
      end)

    end
  }
}
