-- |--------------------|
-- | Begin GUI Settings |
-- |--------------------|

-- Show a real status line
vim.opt.laststatus = 2

-- Always show the tabline
vim.opt.showtabline = 2

-- Increase the number of tabs open at startup
vim.opt.tabpagemax = 15

-- Hide the default mode indicator (using lightline instead)
vim.opt.showmode = false

-- Open new splits to the bottom or right side
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Visual
vim.opt.background = 'dark'

-- A bunch of colorschemes, including jellybeans, are failing to set the colors
-- of the current version of fzf.vim (0.23.0-0.25.0) and so displaying default,
-- mismatching colors. However some colorschemes are setting fzf colors, and
-- since gruvbox somewhat matches jellybeans, I am assigning the colorscheme
-- first to gruvbox, then to jellybeans.
--vim.cmd('colorscheme gruvbox')
--vim.cmd('colorscheme OceanicNext')

--require('OceanicNext').setup({
    --disable_background = true
--})


-- TODO: Figure out what this does
--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


-- Set the SpellBad highlighting
vim.cmd('highlight clear SpellBad')
vim.cmd('highlight SpellBad cterm=underline ctermbg=9 gui=underline guibg=#902020 guisp=Red')

-- Relative line number
vim.opt.number = true           -- Show current line number
vim.opt.relativenumber = true   -- Show relative line numbers

-- Set the font
vim.o.guifont = 'FuraCode_NF:h11,Fira_Code:h11,Consolas:h11'

-- Must be set before GUI is loaded, don't move to gvimrc.
-- For flag explanation, read http://vimdoc.sourceforge.net/htmldoc/options.html#'guioptions'
-- Disable menus and preserve window sizing
vim.o.guioptions = 'Mk'

-- Set the highlight colors for bookmarking
vim.cmd('highlight BookmarkSign guibg=#303030 guifg=#870000')
vim.cmd('highlight BookmarkAnnotationSign guibg=#303030 guifg=#5fdf00')
vim.cmd('highlight BookmarkLine guibg=#262626 guifg=None')
vim.cmd('highlight BookmarkAnnotationLine guibg=#303030 guifg=None')

-- Check if Tmux is running and set tmuxline preset
if vim.fn.executable('tmux') == 1 and vim.fn.filereadable(vim.fn.expand('~/.zshrc')) == 1 and vim.env.TMUX ~= '' then
  vim.g.tmuxline_preset = 'tmux'
end

-- Disable automatic setting of the cursor
vim.o.guicursor = ''

-- Check if any buffers were changed outside of Vim when changing focus
vim.cmd('autocmd FocusGained,BufEnter * checktime')

-- Disable mouse
vim.o.mouse = ''

-- No beeping
vim.opt.visualbell = false

-- No flashing
vim.opt.errorbells = false

-- |------------------|
-- | End GUI Settings |
-- |------------------|

-- |----------------------------------|
-- | Begin Line Modification Settings |
-- |----------------------------------|

-- Display tabs as characters
vim.opt.list = true
vim.opt.listchars = {tab = '>-'}

vim.opt.autoindent = true
vim.opt.smartindent = true

-- Tab width in spaces
vim.opt.tabstop = 4

-- Size of indent in spaces
vim.opt.shiftwidth = 4

-- Make spaces feel like real tabs
vim.opt.softtabstop = 4

-- Convert tabs to spaces
vim.opt.expandtab = true

-- |--------------------------------|
-- | End Line Modification Settings |
-- |--------------------------------|

-- |----------------------------------|
-- | Begin Clipboard/Yanking Settings |
-- |----------------------------------|

-- Sets the default register to use the "* reg on Windows.
if vim.fn.has('win32') == 1 then
    vim.opt.clipboard = 'unnamed'
else
    vim.opt.clipboard = 'unnamedplus'
end

-- |--------------------------------|
-- | End Clipboard/Yanking Settings |
-- |--------------------------------|

-- |-----------------------------------|
-- | Begin Search and Replace Settings |
-- |-----------------------------------|

-- Set the default search to use smartcase
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight all search matches
vim.o.hlsearch = true
-- Highlight all search matches while searching
vim.o.incsearch = true

-- |---------------------------------|
-- | End Search and Replace Settings |
-- |---------------------------------|
