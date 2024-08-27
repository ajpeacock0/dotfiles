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

-- Relative line number
vim.opt.number = true           -- Show current line number
vim.opt.relativenumber = true   -- Show relative line numbers

-- Set the font
vim.o.guifont = 'FuraCode_NF:h11,Fira_Code:h11,Consolas:h11'

-- Must be set before GUI is loaded, don't move to gvimrc.
-- For flag explanation, read http://vimdoc.sourceforge.net/htmldoc/options.html#'guioptions'
-- Disable menus and preserve window sizing
-- vim.o.guioptions = 'Mk' -- DISABLED when updated to neovim 0.10.1

if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
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
