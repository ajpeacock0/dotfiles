-- |------------------|
-- | General Mappings |
-- |------------------|

-- Remap leader from '\' to ','
vim.g.mapleader = ","

-- Use Ctrl-c as the escape
vim.api.nvim_set_keymap('n', '<c-c>', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-c>', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('v', '<c-c>', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('o', '<c-c>', '<esc>', { noremap = true })

-- Map [leader-f] leader-q to [force] quit
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fq', ':q!<cr>', { noremap = true })

-- Map Leader w to write
vim.api.nvim_set_keymap('n', '<leader>w', ':w<Cr>', { noremap = true })

-- Change virtualedit mode
vim.api.nvim_set_keymap('n', '<leader>vd', ':set virtualedit=""<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>va', ':set virtualedit=all<cr>', { noremap = true })

-- Alias for :Buffers
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<Cr>', { noremap = true })

-- Alias for :e! (force reload buffer)
vim.api.nvim_set_keymap('n', '<leader>e', ':e!<Cr>', { noremap = true })

-- Alias for deleting the current file
vim.api.nvim_set_keymap('n', '<leader>rm', ':call delete(expand("%")) \\| bdelete!<CR>', { noremap = true })

-- Add Ctrl+j/k for when popup menu is showing
vim.api.nvim_set_keymap('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"', { expr = true })
vim.api.nvim_set_keymap('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"', { expr = true })

-- Add Tab and Shift-Tab for when popup menu is showing
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })

-- Edit vimr configuration file
vim.api.nvim_set_keymap('n', '<leader>ve', ':e $MYVIMRC<CR>', { noremap = true })

-- Reload vimr configuration file
vim.api.nvim_set_keymap('n', '<leader>vr', ':source $MYVIMRC<CR>', { noremap = true })

-- Shortcut for Vertical Explore
vim.api.nvim_set_keymap('n', '<leader>vx', ':Vex<CR>', { noremap = true })

-- Shortcut for Yes/No for enabling paste mode
vim.api.nvim_set_keymap('n', '<leader>py', ':set paste<Cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pn', ':set nopaste<CR>', { noremap = true })

-- Shortcut for Yes/No for enabling diff mode
vim.api.nvim_set_keymap('n', '<leader>dy', ':windo diffthis<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dn', ':windo diffoff<CR>', { noremap = true })

-- Toggle Word Wrap
vim.api.nvim_set_keymap('n', '<leader>lw', ':set wrap!<CR>', { noremap = true })

-- |----------------------------------|
-- | Begin Line Modification Mappings |
-- |----------------------------------|

-- Map Ctrl-j to line Join command
vim.api.nvim_set_keymap('n', '<C-j>', ':j<cr>', {})

-- Strip Whitespace
vim.api.nvim_set_keymap('n', '<leader>sw', ':StripWhitespace<cr>', {})

-- Fix conversion errors
function FixConversion()
    vim.cmd([[%s//'/ge]])
    vim.cmd([[%s//-/ge]])
    vim.cmd([[%s//"/ge]])
    vim.cmd([[%s//"/ge]])
    vim.cmd([[%s// - /ge]])
    vim.cmd([[%s/​//ge]])
    vim.cmd([[%s///ge]])
    vim.cmd([[%s///ge]])
    vim.cmd([[%s/“/"/ge]])
    vim.cmd([[%s/”/"/ge]])
    vim.cmd([[%s/‘/'/ge]])
    vim.cmd([[%s/’/'/ge]])
    vim.cmd([[%s/–/-/ge]])
    vim.cmd([[%s/¿/'/ge]])
end

vim.api.nvim_set_keymap('n', '<leader>fix', ':call FixConversion()<cr>', { noremap = true })

-- Change all the existing tab characters to match the current tab settings
vim.api.nvim_set_keymap('n', '<leader>tab', ':set et<cr> :ret!<cr>', {})

-- From the current line to EOF, insert new line for each match of the cursor WORD
vim.api.nvim_set_keymap('n', '<leader>nn', ':.,$g/<C-r>=expand("<cWORD>")<CR>/normal o', {})

-- Delete every line which contains the current word
vim.api.nvim_set_keymap('n', '<leader>dd', ':.,$g/<C-r>=expand("<cWORD>")<CR>/d', {})

-- Gheto custom autoclose mappings
vim.api.nvim_set_keymap('i', '(', '()<left>', {})
vim.api.nvim_set_keymap('i', '[', '[]<left>', {})
vim.api.nvim_set_keymap('i', '{', '{}<left>', {})
vim.api.nvim_set_keymap('i', '<', '<><left>', {})
vim.api.nvim_set_keymap('i', '{<cr>', '{<cr>}<ESC>O', {})
vim.api.nvim_set_keymap('i', '{;<cr>', '{<cr>};<ESC>O', {})

-- Map Ctrl+z/x to decrement/increment
vim.api.nvim_set_keymap('n', '<C-z>', '<C-x>', {})
vim.api.nvim_set_keymap('n', '<C-x>', '<C-a>', {})

-- Format JSON in butter using `jq` tool
vim.api.nvim_set_keymap('n', '<leader>jq', ':%!jq .<cr>', {})

-- Set XML formatting for buffer
vim.api.nvim_set_keymap('n', '<leader>xq', ':set formatexpr=xmlformat#Format()<cr>', {})

-- |--------------------------------|
-- | End Line Modification Mappings |
-- |--------------------------------|

-- |--------------------|
-- | Begin Tab Mappings |
-- |--------------------|

-- Map Ctrl-l to go to next tab
vim.api.nvim_set_keymap('n', '<C-l>', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<C-\\><C-n>:tabnext<CR>', { noremap = true })

-- Map Ctrl-h to go to previous tab
vim.api.nvim_set_keymap('n', '<C-h>', ':tabprevious<CR>', { noremap = true })

-- Map Alt-h to go to move this tab to the left
vim.api.nvim_set_keymap('n', '<M-h>', ':tabmove -1<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-h>', '<C-\\><C-n>:tabmove -1<CR>', { noremap = true })

-- Map Alt-l to go to move this tab to the right
vim.api.nvim_set_keymap('n', '<M-l>', ':tabmove +1<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-l>', '<C-\\><C-n>:tabmove +1<CR>', { noremap = true })

-- Map Ctrl-n to create a new blank tab
vim.api.nvim_set_keymap('n', '<C-n>', ':tabnew<CR>', { noremap = true })

-- Map [Ctrl-f] Ctrl-k to [force] kill/close the current tab
vim.api.nvim_set_keymap('n', '<C-k>', ':tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f><C-k>', ':tabclose!<CR>', { noremap = true })

-- Map Ctrl+w and angle brackets to move window splits (matching Tmux)
vim.api.nvim_set_keymap('n', '<C-w><', '<C-w><S-H>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>>', '<C-w><S-L>', { noremap = true })

-- Mapping for window vertical resize
vim.api.nvim_set_keymap('n', '<C-w><C-x>', ':vertical resize +5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w><C-z>', ':vertical resize -5<CR>', { noremap = true })

-- Shortcut to open empty vertical buffer
vim.api.nvim_set_keymap('n', '<leader>vn', ':vnew<CR>', { noremap = true })
-- Shortcut to open empty horizontal buffer
vim.api.nvim_set_keymap('n', '<leader>sn', ':new<CR>', { noremap = true })

-- Mappings for opening the native terminal
if vim.fn.has('win32') == 1 then
    vim.api.nvim_set_keymap('n', '<C-s><C-e>', ':edit term://pwsh<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s><C-n>', ':tabnew term://pwsh<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s><C-s>', ':split term://pwsh<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s><C-v>', ':vsplit term://pwsh<cr>', { noremap = true })
else
    vim.api.nvim_set_keymap('n', '<C-s><C-e>', ':edit term://zsh<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s><C-n>', ':tabnew term://zsh<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s><C-s>', ':split term://zsh<cr>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-s><C-v>', ':vsplit term://zsh<cr>', { noremap = true })
end

-- Custom map to exit terminal-mode
vim.api.nvim_set_keymap('t', '<C-s><C-c>', '<C-\\><C-n>', { noremap = true })

-- |--------------------|
-- | End Tab Mappings |
-- |--------------------|

-- |---------------------------|
-- | Begin Navigation Mappings |
-- |---------------------------|

-- Shift+dir to jump paragraphs
vim.api.nvim_set_keymap('n', '<S-k>', '{', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-j>', '}', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-k>', '{', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-j>', '}', { noremap = true })

-- Shift+dir to jump to begin/end of line
vim.api.nvim_set_keymap('n', '<S-h>', '^', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-l>', '$', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-h>', '^', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-l>', '$', { noremap = true })

-- Center screen after a Next
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })

-- Faster scrolling
vim.api.nvim_set_keymap('n', '<C-d>', '5<C-e>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-u>', '5<C-y>', { noremap = true })

-- Shortcut to the position where the last change was made.
vim.api.nvim_set_keymap('n', '<leader>mm', '`.', { noremap = true })

-- Shortcut to the first character of the previously changed or YANKED text
vim.api.nvim_set_keymap('n', '<leader>my', '`[', { noremap = true })

-- Shortcut to the position where the cursor was the last time when INSERT mode was stopped.
vim.api.nvim_set_keymap('n', '<leader>mi', '`^', { noremap = true })

-- |-------------------------|
-- | End Navigation Mappings |
-- |-------------------------|

-- |----------------------------------|
-- | Begin Clipboard/Yanking Mappings |
-- |----------------------------------|

-- Sets the default register to use the "* reg on Windows.
if vim.fn.has('win32') == 1 then
    vim.opt.clipboard = 'unnamed'
else
    vim.opt.clipboard = 'unnamedplus'
end

-- |--------------------------------|
-- | End Clipboard/Yanking Mappings |
-- |--------------------------------|

-- Yank the Name of the current file
vim.api.nvim_set_keymap('n', '<leader>yn', ':let @+ = expand("%")<CR>', { noremap = true })

-- Alt-e Keybinding for substitute word with yanked register
vim.api.nvim_set_keymap('n', '<M-e>', 've"0p', { noremap = true })

-- Alt-p Keybinding for paste yanked register
vim.api.nvim_set_keymap('n', '<M-p>', '"0p', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-P>', '"0P', { noremap = true })

-- Alt-p Keybinding for paste yanked register when in visual mode
vim.api.nvim_set_keymap('v', '<M-p>', '"0p', { noremap = true })

-- Yank from the cursor to the end of the line, to be consistent with C and D.
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- |-----------------------------------|
-- | Begin Search and Replace Mappings   |
-- |-----------------------------------|

-- Unhighlight search terms with leader+space
vim.api.nvim_set_keymap('n', '<leader><space>', ':noh<CR>', { noremap = true })

-- Prepare RipGrep with an empty argument without execution
vim.api.nvim_set_keymap('n', '<leader>re', ':Rg', { noremap = true })

-- Prepare Ripgrep with an empty argument but matching whole Word
vim.api.nvim_set_keymap('n', '<leader>rw', ':Rg \\b<C-r>=expand("<cword>")<CR>\\b', { noremap = true })

-- Prepare search with an empty argument but matching whole word
vim.api.nvim_set_keymap('n', '<leader>rs', ':/\\<\\>', { noremap = true })

-- RipGrep with the word under the cursor
vim.api.nvim_set_keymap('n', '<leader>rg', ':execute \'Rg \' . expand(\'<cword>\')<CR>', { noremap = true })

-- RePlace whole word
vim.api.nvim_set_keymap('n', '<leader>rr', ':%s/\\<<C-r>=expand("<cword>")<CR>\\>/\\<C-r>=expand("<cword>")<CR>/g', { noremap = true })

-- RePlace word, and fill in substitution (RHS) with current word
vim.api.nvim_set_keymap('n', '<leader>rp', ':%s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/g', { noremap = true })

-- Pull word under cursor into LHS of a substitute (find and replace) in all tabs
vim.api.nvim_set_keymap('n', '<leader>trr', ':tabdo %s#\\<<C-r>=expand("<cword>")<CR>\\>#', { noremap = true })

-- Same thing, but global within the line and don't match whole word in all tabs
vim.api.nvim_set_keymap('n', '<leader>trw', ':tabdo %s/<C-r>=expand("<cword>")<CR>//g', { noremap = true })

-- RePlace word in all tabs
vim.api.nvim_set_keymap('n', '<leader>trp', ':tabdo %s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/g', { noremap = true })

-- |---------------------------------|
-- | End Search and Replace Mappings |
-- |---------------------------------|

-- |-------------------------|
-- | Begin Spelling Mappings |
-- |-------------------------|

-- Toggle SPell checker
vim.api.nvim_set_keymap('n', '<leader>sp', ':setlocal spell spelllang=en_us<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', ':setlocal spell!<cr>', { noremap = true, silent = true })

-- Spell Complete using the most likely suggestion
vim.api.nvim_set_keymap('n', '<leader>sc', '1z=', { noremap = true, silent = true })

-- Spell Previous
vim.api.nvim_set_keymap('n', '<leader>sa', '[s', { noremap = true, silent = true })

-- Spell Next
vim.api.nvim_set_keymap('n', '<leader>sd', ']s', { noremap = true, silent = true })

function FzfSpellSink(word)
  vim.api.nvim_command('_ciw' .. word)
end

function FzfSpell()
  local suggestions = vim.fn.spellsuggest(vim.fn.expand("<cword>"))
  vim.fn['fzf#run']({ source = suggestions, sink = function(word) FzfSpellSink(word) end, down = 10 })
end

-- Spell Suggest using fzf
vim.api.nvim_set_keymap('n', '<leader>ss', ':call FzfSpell()<CR>', { noremap = true, silent = true })

-- |-----------------------|
-- | End Spelling Mappings |
-- |-----------------------|
--
-- |------------------------|
-- | Begin Custom Functions |
-- |------------------------|

function MarkdownBookmark()
    vim.cmd(":s/.*/\\L&/g")
    vim.cmd(":s/\\ /-/g")
end

-- Convert camel case to Java constant style
function JavaUpperCase()
    vim.cmd(":s/\\(\\u\\)/_\\1/g")
    vim.cmd(":s/.*/\\U&/g")
end

-- Add argument (can be negative, default 1) to global variable i.
-- Return value of i before the change.
function Inc(arg)
  local result = vim.g.i
  vim.g.i = vim.g.i + (arg or 1)
  return result
end

-- Pull word under cursor into LHS of a increasing number addition
vim.api.nvim_set_keymap('n', '<leader>inc', [[:let i = 1<CR>:%s/\V<C-r><C-w>/\=submatch(0) .. Inc()/g<CR>]], { noremap = true })

-- Convert Java constant style to camel case
function JavaLowerCase()
    vim.cmd(":s/.*/\\L&/g")
    vim.cmd(":s/_\\(\\l\\)/\\U\\1/g")
end

-- Map java constant case functions to keys
vim.api.nvim_set_keymap('n', '<leader>ju', [[:call JavaUpperCase()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>jl', [[:call JavaLowerCase()<CR>]], { noremap = true })

-- |----------------------|
-- | End Custom Functions |
-- |----------------------|
