-- |-----------------------|
-- | Begin Plugin Mappings |
-- |-----------------------|

-- Make vim-table-mode use markdown compatable corner seperators
vim.g.table_mode_corner = '|'

-- Tell vim-whitespace to strip whitespace on save
vim.g.strip_whitespace_on_save = 0

-- Enable Rainbow Parenthesis
vim.g.rainbow_active = 1

-- Set the textwidth for Markdown files
vim.api.nvim_command('autocmd FileType markdown setlocal textwidth=110')

-- Vim Markdown settings
vim.g.vim_markdown_folding_disabled = 1
vim.cmd('set nofoldenable')
vim.g.vim_markdown_fenced_languages = {'csharp=cs'}
vim.opt.conceallevel = 0

-- netrw Settings
vim.g.netrw_banner = 0

-- open files in a new tab
vim.g.netrw_browse_split = 3

-- Close vim if the only window left open is a NERDTree
vim.api.nvim_command([[
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
]])

-- Automatically close bookmarks split when jumping to a bookmark
vim.g.bookmark_auto_close = 1

-- Disable warning when clearing all bookmarks
vim.g.bookmark_show_warning = 0

-- Disables warning when toggling to clear a bookmark with annotation
vim.g.bookmark_show_toggle_warning = 0

-- Center when jumping to bookmark
vim.g.bookmark_center = 1

-- Highlight the line when bookmarked
vim.g.bookmark_highlight_lines = 1

vim.g.bookmark_annotation_sign = '♠'
