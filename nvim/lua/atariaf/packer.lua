-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Finding files and shit.
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- The theme.
    use({
        "folke/tokyonight.nvim",
        as = 'tokyonight',
        config = function()
            vim.cmd('colorscheme tokyonight-night')
        end
    })

    -- Treesitter
    use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- Harpoon, because why not?
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    -- I never have to undo.
    use ('mbbill/undotree')

    -- Git wrapper. Use :Git command
    -- Same commands as git.
    use('tpope/vim-fugitive')

    -- LSP Support
    -- Using neovim LSP
    use('neovim/nvim-lspconfig')

    -- Mason, the LSP package manager.
    use('williamboman/mason.nvim')

    -- Mason config that helps bridge the gap between nvim-lspconfig and mason.
    use('williamboman/mason-lspconfig.nvim')

    -- Autocompletion
    use('hrsh7th/nvim-cmp')

    use('hrsh7th/cmp-nvim-lsp')

    -- Snippets
    use('L3MON4D3/LuaSnip')

    -- Obsidian Neovim
    use{
        "epwalsh/obsidian.nvim",
        tag = "*",  -- recommended, use latest release instead of latest commit
        requires = {
            "nvim-lua/plenary.nvim",
        },
    }

end)
