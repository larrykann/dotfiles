return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.icons').setup({})

      local statusline = require 'mini.statusline'
      statusline.setup { user_icons = true }
    end
  }
}
