-- |------------------|
-- | General Mappings |
-- |------------------|

print("Loading mappings.lua...")

-- Use which-key for mappings to gain descriptions
local wk = require("which-key")

-- Remap leader from '\' to ','
vim.g.mapleader = ","

-- Use Ctrl-c as the escape
wk.register({
    ['<c-c>']  = {'<esc>', 'Use Ctrl-c as the escape', mode={'n','i','v','o'}},
})

wk.register({
    ['<leader>q']   = {':q<cr>'                   , 'Shortcut to quit'                      },
    ['<leader>fq']  = {':bdelete!<cr>'            , 'Shortcut to force delete buffer'       },
    ['<leader>w']   = {':w<cr>'                   , 'Map Leader w to write'                 },
    ['<leader>va']  = {':set virtualedit=all<cr>' , 'Change virtualedit mode to all'        },
    ['<leader>vd']  = {':set virtualedit=""<cr>'  , 'Change virtualedit mode to default'    },
    ['<leader>b']   = {':Buffers<cr>'             , 'Alias for :Buffers'                    },
    ['<leader>e']   = {':e!<cr>'                  , 'Alias for :e! (force reload buffer)'   },
    ['<leader>rm']  = { function()
        vim.cmd("call delete(expand('%'))")
        vim.cmd("bdelete!")
    end, "Alias for deleting the current file"                                              },
})

-- Add Ctrl+j/k for when popup menu is showing
vim.api.nvim_set_keymap('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"', { expr = true })
vim.api.nvim_set_keymap('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"', { expr = true })

-- Add Tab and Shift-Tab for when popup menu is showing
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })

wk.register({
    ['<leader>ve']      = {':e $MYVIMRC<CR>',      'Edit the MYVIMRC configuration file'        },
    ['<leader>vr']      = {':source $MYVIMRC<CR>', 'Reload MYVIMRC configuration file'          },
    ['<leader>vx']      = {':Vex<CR>',             'Shortcut for Vertical Explore'              },
    ['<leader>py']      = {':set paste<Cr>',       'Shortcut for enabling paste mode'           },
    ['<leader>pn']      = {':set nopaste<CR>',     'Shortcut for disabling paste mode'          },
    ['<leader>dy']      = {':windo diffthis<CR>',  'Shortcut for enabling diff mode'            },
    ['<leader>dn']      = {':windo diffoff<CR>',   'Shortcut for disabling diff mode'           },
    ['<leader>lw']      = {':set wrap!<CR>',       'Toggle Word Wrap'                           },
    ['<leader><space>'] = {':noh<CR>',             'Unhighlight search terms with leader+space' },
})

-- |----------------------------------|
-- | Begin Line Modification Mappings |
-- |----------------------------------|

wk.register({
    ['<C-z>']       = {'<C-x>'                                  , "Decrement number"                                         },
    ['<C-x>']       = {'<C-a>'                                  , "Increment number"                                         },
    ['<C-j>']       = {':j<cr>'                                 , "Line join command"                                        },
    ['<leader>sw']  = {':StripWhitespace<cr>'                   , "Strip Whitespace"                                         },
    ['<leader>tab'] = {':set et<cr> :ret!<cr>'                  , "Change all existing tab characters to match tab settings" },
    ['<leader>jq']  = {':%!jq .<cr>'                            , 'Format JSON in butter using `jq` tool'                    },
    ['<leader>xq']  = {':set formatexpr=xmlformat#Format()<cr>' , 'Set XML formatting for buffer'                            },

    ['<leader>nn']  = { function()
        vim.cmd(".,$g/"..vim.fn.expand("<cWORD>").."/normal o")
    end, "From the current line to EOF, insert new line for each match of the cursor WORD"                                   },

    ['<leader>dd']  = { function()
        vim.cmd(".,%g/"..vim.fn.expand("<cWORD>").."/d")
    end, "Delete every line which contains the current word"                                                                 },

    ['<leader>fix'] = { function()
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
    end, "Fix conversion errors"                                                                                             },

})

wk.register({
    -- Gheto custom autoclose mappings
    ['(']      = {'()<left>'      , "Custom autoclose mapping" },
    ['[']      = {'[]<left>'      , "Custom autoclose mapping" },
    ['{']      = {'{}<left>'      , "Custom autoclose mapping" },
    ['<']      = {'<><left>'      , "Custom autoclose mapping" },
    ['{<cr>']  = {'{<cr>}<ESC>O'  , "Custom autoclose mapping" },
    ['{;<cr>'] = {'{<cr>};<ESC>O' , "Custom autoclose mapping" },
},{
    mode = "i", -- INSERT mode
})

-- Align Plugin Mappings
wk.register({
    ['<leader>aa'] = { function() require'align'.align_to_char(1, true)             end, "Aligns to 1 character, looking left"                     },
    ['<leader>as'] = { function() require'align'.align_to_char(2, true, true)       end, "Aligns to 2 characters, looking left and with previews"  },
    ['<leader>aw'] = { function() require'align'.align_to_string(false, true, true) end, "Aligns to a string, looking left and with previews"      },
    ['<leader>ar'] = { function() require'align'.align_to_string(true, true, true)  end, "Aligns to a Lua pattern, looking left and with previews" },
},{
    mode = "x", -- Visual mode
})

-- |--------------------------------|
-- | End Line Modification Mappings |
-- |--------------------------------|

-- |--------------------|
-- | Begin Tab Mappings |
-- |--------------------|

wk.register({
    ['<C-l>']      = { function() vim.cmd(':tabnext') end            , "Go to next tab", mode={'n','i','v'}                      },
    ['<C-h>']      = { function() vim.cmd(':tabprevious') end        , "Go to previous tab", mode={'n','i','v'}                  },
    ['<M-l>']      = { function() vim.cmd('silent! :tabmove +1') end , "Move this tab to the right", mode={'n','i','v'}          },
    ['<M-h>']      = { function() vim.cmd('silent! :tabmove -1') end , "Move this tab to the left", mode={'n','i','v'}           },
    ['<C-n>']      = { function() vim.cmd(':tabnew') end             , "Create a new blank tab", mode={'n','i','v'}              },
    ['<C-w>,']     = {'<C-w><S-H>'                                   , 'Move window split to left'      , mode={'n','v'}         },
    ['<C-w>.']     = {'<C-w><S-L>'                                   , 'Move window split to right', mode={'n','v'}              },
    ['<C-w><C-l>'] = {':vertical resize +10<CR>'                     , 'Mapping for window vertical resize', mode={'n','v'}      },
    ['<C-w><C-h>'] = {':vertical resize -10<CR>'                     , 'Mapping for window vertical resize', mode={'n','v'}      },
    ['<C-w><C-j>'] = {':horizontal resize +7<CR>'                    , 'Mapping for window vertical resize', mode={'n','v'}      },
    ['<C-w><C-k>'] = {':horizontal resize -7<CR>'                    , 'Mapping for window vertical resize', mode={'n','v'}      },
    ['<leader>vn'] = {':vnew<CR>'                                    , 'Shortcut to open empty vertical buffer', mode={'n','v'}  },
    ['<leader>vs'] = {':new<CR>'                                     , 'Shortcut to open empty horizontal buffer', mode={'n','v'}},
})

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

wk.register({
    ['<S-k>']      = {'{'     , 'Shift+dir to jump paragraphs', mode={'n','v'}                                              },
    ['<S-j>']      = {'}'     , 'Shift+dir to jump paragraphs', mode={'n','v'}                                              },
    ['<S-h>']      = {'^'     , 'Shift+dir to jump to begin/end of line', mode={'n','v'}                                    },
    ['<S-l>']      = {'$'     , 'Shift+dir to jump to begin/end of line', mode={'n','v'}                                    },
    ['n']          = {'nzz'   , 'Center screen after a Next'                                                                },
    ['N']          = {'Nzz'   , 'Center screen after a Next'                                                                },
    ['<C-d>']      = {'5<C-e>', 'Faster scrolling'                                                                          },
    ['<C-u>']      = {'5<C-y>', 'Faster scrolling'                                                                          },
    ['<leader>mm'] = {'`.'    , 'Shortcut to the position where the last change was made.'                                  },
    ['<leader>my'] = {'`['    , 'Shortcut to the first character of the previously changed or YANKED text'                  },
    ['<leader>mi'] = {'`^'    , 'Shortcut to the position where the cursor was the last time when INSERT mode was stopped.' },
})

-- |-------------------------|
-- | End Navigation Mappings |
-- |-------------------------|

-- |----------------------------------|
-- | Begin Clipboard/Yanking Mappings |
-- |----------------------------------|

wk.register({
    ['<leader>yn'] = {':let @+ = expand("%")<CR>', 'Yank the Name of the current file'                                           },
    ['<M-e>']      = {'ve"0p'                    , 'Keybinding for substitute word with yanked register'                         },
    ['<M-p>']      = {'"0p'                      , 'Keybinding for paste yanked register', mode={'n','v'}                        },
    ['<M-P>']      = {'"0P'                      , 'Keybinding for paste yanked register', mode={'n','v'}                        },
    ['Y']          = {'y$'                       , 'Yank from the cursor to the end of the line, to be consistent with C and D.' },
})

-- |--------------------------------|
-- | End Clipboard/Yanking Mappings |
-- |--------------------------------|

-- |-----------------------------------|
-- | Begin Search and Replace Mappings |
-- |-----------------------------------|

-- I don't use which-key for these since then they are loaded into the commandline,
-- the buffer isn't loaded, so it appears blank. Not until you move is it filled in

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

wk.register({
    ['<leader>sp'] = {':setlocal spell! spelllang=en_us<cr>', 'Toggle SPell checker'                            },
    ['<leader>sc'] = {'1z='                                 , 'Spell Complete using the most likely suggestion' },
    ['<leader>sa'] = {'[s'                                  , 'Go to previous incorrect spelling'               },
    ['<leader>sd'] = {']s'                                  , 'Go to next incorrect spelling'                   },

    ['<leader>ss'] = { function()
        local suggestions = vim.fn.spellsuggest(vim.fn.expand("<cword>"))
        vim.fn['fzf#run']({
            source = suggestions,
            sink = function(word)
                vim.api.nvim_command('normal! ciw' .. word)
            end,
            down = 10 })
    end, "Spell Suggest using fzf", noremap = true, silent = true                                               },
})

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
