-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- ControlP (requires fzf installed)
    use {
        'tacahiroy/ctrlp-funky',
        'junegunn/fzf',
        'junegunn/fzf.vim',
    }

    -- Theme
    use { 'rebelot/kanagawa.nvim' }

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
        }
    }

    -- Commenting
    use { 'scrooloose/nerdcommenter' }

    -- Bookmarks
    use { 'MattesGroeger/vim-bookmarks' }

    -- Color Table Display
    use { 'guns/xterm-color-table.vim' }

    -- Better NERDtree alternative
    use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' }

    -- Side windows displaying buffers
    use { 'jeetsukumaran/vim-buffergator' }

    -- Improve the `.` command to include macros, plugin maps, etc.
    use { 'tpope/vim-repeat' }

    -- Moving lines up+down
    use { 'matze/vim-move' }

    -- Improved status line (e.g. file named)
    use { 'itchyny/lightline.vim' }

    -- Tmux statusline generator
    use { 'edkolev/tmuxline.vim' }

    -- Toggle surroundings around text
    use { 'tpope/vim-surround' }

    -- Improved Rainbow Parenthesis
    use { 'luochen1990/rainbow' }

    -- Git features
    use { 'tpope/vim-fugitive' }

    -- Displays line signs for changes when in a git repo
    use { 'airblade/vim-gitgutter' }

    -- Markdown syntax highlighting, since the treesitter one is much worse
    use { 'godlygeek/tabular', 'plasticboy/vim-markdown' }

    -- EOL whitespace removal
    use { 'ntpeters/vim-better-whitespace' }

    -- Formatting Markdown tables
    use { 'dhruvasagar/vim-table-mode' }

    -- Copilot Suggestions
    use { 'github/copilot.vim' }

    -- Display the mappings
    use { "folke/which-key.nvim" }

    -- Alligning lines
    use { 'Vonr/align.nvim' }

    -- Syntax Highlighting
    use { "nvim-treesitter/nvim-treesitter" }
end)
