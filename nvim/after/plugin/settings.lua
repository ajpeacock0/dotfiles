-- |--------------------|
-- | Begin GUI Settings |
-- |--------------------|

-- Set the SpellBad highlighting
vim.cmd('highlight clear SpellBad')
vim.cmd('highlight SpellBad cterm=underline ctermbg=9 gui=underline guibg=#902020 guisp=Red')

-- Set the highlight colors for bookmarking
vim.cmd('highlight BookmarkSign guibg=#303030 guifg=#870000')
vim.cmd('highlight BookmarkAnnotationSign guibg=#303030 guifg=#5fdf00')
vim.cmd('highlight BookmarkLine guibg=#262626 guifg=None')
vim.cmd('highlight BookmarkAnnotationLine guibg=#303030 guifg=None')

-- Check if Tmux is running and set tmuxline preset
if vim.fn.executable('tmux') == 1 and vim.fn.filereadable(vim.fn.expand('~/.zshrc')) == 1 and vim.env.TMUX ~= '' then
  vim.g.tmuxline_preset = 'tmux'
end

-- |------------------|
-- | End GUI Settings |
-- |------------------|
