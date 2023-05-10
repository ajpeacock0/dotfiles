-- |-----------------------|
-- | Begin Plugin Mappings |
-- |-----------------------|

-- Ctrl-P mapping using fzf
if vim.fn.executable('fzf') then
    vim.g.fzf_layout = { down = '~40%' }

    -- Override `Files` with different fzf options
    vim.cmd([[command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--info=inline']}, <bang>0)]])
    vim.cmd([[command! -bang -nargs=? -complete=dir GFiles call fzf#vim#gitfiles(<q-args>, {'options': ['--info=inline']}, <bang>0)]])

    -- Override `Rg` with no preview window
    vim.cmd([[command! -bang -nargs=? -complete=dir Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --no-hidden --ignore -- ".shellescape(<q-args>), 1, <bang>0)]])

    -- Create `RG` to search hidden and git ignored files
    vim.cmd([[command! -bang -nargs=? -complete=dir RG call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore -- " .shellescape(<q-args>), 1, <bang>0)]])

    -- Override `Buffers` with no preview window
    vim.cmd([[command! -bang -nargs=? -complete=dir Buffers call fzf#vim#buffers(<q-args>, {'options': ''}, <bang>0)]])

    -- Remap CtrlP mappings to FZF
    vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-o>', ':call fzf#run({\'sink\': \'e\', \'options\': \'--multi --no-mouse\', \'down\': \'40%\'})<CR>', { noremap = true })

    -- Run Fzf using git ls-files (useful for finding hidden, but not ignored, files)
    vim.api.nvim_set_keymap('n', '<C-i>', ':GFiles<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<Leader>ct', ':Tags<CR>', { noremap = true })

    -- Search tags with the word under the cursor
    vim.api.nvim_set_keymap('n', '<Leader>cw', ':execute \'Tags \' . expand(\'<cword>\')<CR>', { noremap = true })
else
    -- If there is no fzf on this machine, use CtrlP
    -- Enable CtrlP extensions
    vim.g.ctrlp_extensions = { 'funky' }
    --
    -- Fix CommandP by switching the searching tool to something that works and is faster
    if vim.fn.executable('fd') then
        vim.g.ctrlp_user_command = 'fd --type file'
    end

    -- Keys for CtrlP Funky
    vim.api.nvim_set_keymap('n', '<Leader>fu', ':CtrlPFunky<CR>', { noremap = true })
    -- narrow the list down with a word under cursor
    vim.api.nvim_set_keymap('n', '<Leader>fU', ':execute \'CtrlPFunky \' . expand(\'<cword>\')<CR>', { noremap = true })
end

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

-- CHADtree Toggle
vim.api.nvim_set_keymap('n', '<C-t>', ':CHADopen<CR>', { noremap = true })

-- CHADtree change selection
vim.g.chadtree_settings = {
  keymap = {
    select = {'<space>'},
    trash = {},
    tertiary = {'t'},
    new = {'n'},
    rename = {'m'},
    copy = {'c'},
    change_focus = {'p'},
    change_focus_up = {'P'},
    v_split = {'v'},
    h_split = {'V'},
  },
}

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

-- MawkdDown preview Toggle
vim.api.nvim_set_keymap('n', '<leader>md', ':MarkdownPreviewToggle<CR>', {})

vim.g.vista_sidebar_position = 'vertical topleft'
vim.g.vista_sidebar_width = '35'
vim.g.vista_icon_indent = {"╰▸ ", "├▸ "}

-- Vista Toggle
vim.api.nvim_set_keymap('n', '<leader>vt', ':Vista!!<CR>', {})

-- show json path in the winbar
--if vim.api.nvim_get_option('winbar') then
-- vim.opt_local.winbar = '%{luaeval('require"jsonpath".get())}'
--end

-- Enable/Disable copilot filetypes
vim.g.copilot_filetypes = {
    ['xml'] = false,
    ['markdown'] = false,
}

-- Determines timout for which-key to appear
vim.o.timeout = true
vim.o.timeoutlen = 800

require("which-key").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
    popup_mappings = {
        scroll_down = "<c-j>", -- binding to scroll down inside the popup
        scroll_up = "<c-k>", -- binding to scroll up inside the popup
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 80 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
}

-- LSP Config
local lsp = require("lsp-zero")

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup()
