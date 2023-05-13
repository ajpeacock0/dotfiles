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
