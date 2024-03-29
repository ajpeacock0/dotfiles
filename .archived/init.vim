set nocompatible

" |-------------------|
" | Begin Plugin List |
" |-------------------|

call plug#begin('~/AppData/Local/nvim/plugged')

" Autocompletion Plugin and dependencies
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion Sources
Plug 'ncm2/ncm2-bufword'
Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-vim'

" ControlP (requires fzf installed)
Plug 'tacahiroy/ctrlp-funky'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Color Table Display
Plug 'guns/xterm-color-table.vim'

" Better NERDtree alternative
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" Theme Plugin
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Side windows displaying buffers
Plug 'jeetsukumaran/vim-buffergator'

" Improve the `.` command to include macros, plugin maps, etc.
Plug 'tpope/vim-repeat'

" Moving lines up+down
Plug 'matze/vim-move'

" Improved status line (e.g. file named)
Plug 'itchyny/lightline.vim'

" Tmux statusline generator
Plug 'edkolev/tmuxline.vim'

" Toggle surroundings around text
Plug 'tpope/vim-surround'

" Highlight the first char to a word
Plug 'unblevable/quick-scope'

" Improved Rainbow Parenthesis
Plug 'luochen1990/rainbow'

" Git features
Plug 'tpope/vim-fugitive'

" Displays line signs for changes when in a git repo
Plug 'airblade/vim-gitgutter'

" Markdown syntax highlighting
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" EOL whitespace removal
Plug 'ntpeters/vim-better-whitespace'

" Formatting Markdown tables
Plug 'dhruvasagar/vim-table-mode'

" Completion: TODO find out how I use this
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

Plug 'github/copilot.vim'

" JSON Path Syntax
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'phelipetls/jsonpath.nvim'

" XML formatter
Plug 'chrisbra/vim-xml-runtime'

" Initialize plugin system
call plug#end()

"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect

" Make the backspace + delete work like in most other programs
set backspace=indent,eol,start

" |-----------------|
" | End Plugin List |
" |-----------------|

" |------------------------|
" | Begin General Mappings |
" |------------------------|

" Remap leader from '\' to ','
let mapleader = ","

" Use Ctrl-c as the escape
nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" Map [leader-f] leader-q to [force] quit
nnoremap <leader>q :q<cr>
nnoremap <leader>fq :q!<cr>

" Map Leader w to write
nnoremap <leader>w :w<Cr>

" Change virtualedit mode
nmap <leader>vd :set virtualedit=""<cr>
nmap <leader>va :set virtualedit=all<cr>

" Alias for :Buffers
nnoremap <leader>b :Buffers<Cr>

" Alias for :e! (force reload buffer)
nnoremap <leader>e :e!<Cr>

" Alias for deleting the current file
nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>

" Add Ctrl+j/k for when popup menu is showing
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Add Tab and Shift-Tab for when popup menu is showing
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Edit vimr configuration file
nnoremap <leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <leader>vr :source $MYVIMRC<CR>

" Shortcut for Vertical Explore
nnoremap <leader>vx :Vex<CR>

" Shortcut for Yes/No for enabling paste mode
nnoremap <leader>py :set paste<Cr>
nnoremap <leader>pn :set nopaste<Cr>

" Shortcut for Yes/No for enabling diff mode
nnoremap <leader>dy :windo diffthis<Cr>
nnoremap <leader>dn :windo diffoff<Cr>

" Toggle Word Wrap
nmap <leader>lw :set wrap!<cr>

" |----------------------|
" | End General Mappings |
" |----------------------|


" |-----------------------|
" | Begin Plugin Settings |
" |-----------------------|

if (executable('fzf'))
    let g:fzf_layout = { 'down': '~40%' }

    " Override `Files` with different fzf options
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, {'options': ['--info=inline']},
        \ <bang>0)

    command! -bang -nargs=? -complete=dir GFiles
        \ call fzf#vim#gitfiles(<q-args>, {'options': ['--info=inline']},
        \ <bang>0)

    " Override `Rg` with no preview window
    command! -bang -nargs=? -complete=dir Rg
        \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --no-hidden --ignore -- ".shellescape(<q-args>),
        \ 1,
        \ <bang>0)

    " Create `RG` to search hidden and git ignored files
    command! -bang -nargs=? -complete=dir RG
        \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --no-ignore -- ".shellescape(<q-args>),
        \ 1,
        \ <bang>0)

    " Remap CtrlP mappings to FZF
    nnoremap <c-p> :Files<Cr>
    nnoremap <c-o> :call fzf#run({'sink': 'e', 'options': '--multi --no-mouse', 'down': '40%'})<Cr>
    " Run Fzf using git ls-files (useful for finding hidden, but not ignored, files)
    nnoremap <c-i> :GFiles<Cr>
    nnoremap <Leader>ct :Tags<Cr>
    " Search tags with the word under the cursor
    nnoremap <Leader>cw :execute 'Tags ' . expand('<cword>')<Cr>
else
    " If there is no fzf on this machine, use CtrlP
    " Enable CtrlP extensions
    let g:ctrlp_extensions = ['funky']

    " Fix CommandP by switching the searching tool to something that works and is faster
    if (executable('fd'))
        let g:ctrlp_user_command = 'fd --type file'
    endif

    " Keys for CtrlP Funky
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
endif

" Make vim-table-mode use markdown compatable corner seperators
let g:table_mode_corner='|'

" Tell vim-whitespace to strip whitespace on save
let g:strip_whitespace_on_save = 0

" Enable Rainbow Parenthesis
let g:rainbow_active = 1

" Set the textwidth for Markdown files
au FileType markdown setlocal textwidth=110

" Vim Markdown settings
let g:vim_markdown_folding_disabled = 1
set nofoldenable
let g:vim_markdown_fenced_languages = ['csharp=cs']
set conceallevel=0

" Trigger a highlight in the appropriate direction for quick-scope
"let g:qs_enable=0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Stop Typescript errors being shown on buffer save
let g:tsuquyomi_disable_quickfix = 1
autocmd FileType typescript setlocal completeopt+=menu,preview

let g:deoplete#enable_at_startup = 1

" netrw Settings
let g:netrw_banner = 0
" open files in a new tab
let g:netrw_browse_split = 3

" CHADtree Toggle
nnoremap <C-t> :CHADopen<CR>

" CHADtree change selection
let g:chadtree_settings={"keymap":{
                            \"select":["<space>"],
                            \"trash":[],
                            \"tertiary":["t"],
                            \"new": ["n"],
                            \"rename": ["m"],
                            \"copy": ["c"],
                            \"change_focus": ["p"],
                            \"change_focus_up": ["P"],
                            \"v_split": ["v"],
                            \"h_split": ["V"]
                        \}}

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Automatically close bookmarks split when jumping to a bookmark
let g:bookmark_auto_close = 1

" Disable warning when clearing all bookmarks
let g:bookmark_show_warning = 0

" Disables warning when toggling to clear a bookmark with annotation
let g:bookmark_show_toggle_warning = 0

" Center when jumping to bookmark
let g:bookmark_center = 1

" Highlight the line when bookmarked
let g:bookmark_highlight_lines = 1

let g:bookmark_annotation_sign = '♠'

" MawkdDown preview Toggle
nmap <leader>md :MarkdownPreviewToggle<CR>

let g:vista_sidebar_position = 'vertical topleft'
let g:vista_sidebar_width = '35'
let g:vista_icon_indent = ["╰▸ ", "├▸ "]

" Vista Toggle
nnoremap <leader>vt :Vista!!<CR>

" show json path in the winbar
"if exists('+winbar')
"  setlocal winbar=%{luaeval('require\"jsonpath\".get()')}
"endif

let g:copilot_filetypes = {
      \ 'xml': v:false,
      \ 'markdown': v:true,
      \ }

" |---------------------|
" | End Plugin Settings |
" |---------------------|

" |--------------------|
" | Begin GUI Settings |
" |--------------------|

" Show a real status line
set laststatus=2

" Always show the tabline
set showtabline=2

" Increase the number of tabs open at startup
set tabpagemax=15

" Hide the default mode indicator (using lightline instead)
set noshowmode

" Open new splits to the bottom or right side
set splitbelow splitright

" Visual
set background=dark

" A bunch of colorschemes, including jellybeans, are failing to set the colors
" of the current version of fzf.vim (0.23.0-0.25.0) and so displaying default,
" mismatching colors. However some colorschemes are setting fzf colors, and
" since gruvbox somewhat matches jellybeans, I am assigning the colorscheme
" first to gruvbox, then to jellybeans.
colorscheme gruvbox
colorscheme OceanicNext

" Set the SpellBad highlighting
hi clear SpellBad
hi SpellBad cterm=underline ctermbg=9 gui=underline guibg=#902020 guisp=Red

" Relative line number
set number                     " Show current line number
set relativenumber             " Show relative line numbers

set guifont+=FuraCode_NF:h11
set guifont+=Fira_Code:h11
set guifont+=Consolas:h11

" Must be set before GUI is loaded, don't move to gvimrc.
" For flag explanation, read http://vimdoc.sourceforge.net/htmldoc/options.html#'guioptions'
" Disable menus and preserve window sizing
set guioptions=Mk
" Set colorscheme options based on detected 256 color support
if &t_Co == 256
    " Use 24-bit color if available
    if has('termguicolors')
        " Required to set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif
endif

highlight BookmarkSign guibg=#303030 guifg=#870000
highlight BookmarkAnnotationSign guibg=#303030 guifg=#5fdf00
highlight BookmarkLine guibg=#262626 guifg=None
highlight BookmarkAnnotationLine guibg=#303030 guifg=None

if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:tmuxline_preset = 'tmux'
endif

" Disable automatic setting of the cursor
set guicursor=

" Check if any buffers were changed outside of Vim when changing focus
au FocusGained,BufEnter * :checktime

" Disable mouse
set mouse=

" |------------------|
" | End GUI Settings |
" |------------------|

" |----------------------------------|
" | Begin Line Modification Settings |
" |----------------------------------|

" Display tabs as characters
set list
set listchars=tab:>-

set autoindent
set smartindent

" Tab width in spaces
set tabstop=4

" Size of indent in spaces
set shiftwidth=4

" Make spaces feel like real tabs
set softtabstop=4

" Convert tabs to spaces
set expandtab

" |--------------------------------|
" | End Line Modification Settings |
" |--------------------------------|

" |----------------------------------|
" | Begin Line Modification Mappings |
" |----------------------------------|

" Map Ctrl-j to Shift-j; aka line join
nnoremap <c-j> <S-j>
vnoremap <c-j> <S-j>

" Strip Whitespace
nmap <leader>sw :StripWhitespace<cr>

" Fix conversion errors
function! FixConversion()
    :%s//'/ge
    :%s//-/ge
    :%s//"/ge
    :%s//"/ge
    :%s// - /ge
    :%s/​//ge
    :%s///ge
    :%s///ge
    :%s/“/"/ge
    :%s/”/"/ge
    :%s/‘/'/ge
    :%s/’/'/ge
    :%s/–/-/ge
    :%s/¿/'/ge
endfunction
nmap <leader>fix :call FixConversion()<Cr>

" Change all the existing tab characters to match the current tab settings
nmap <leader>tab :set et<cr> :ret!<cr>

" From the current line to EOF, insert new line for each match of the cursor WORD
nnoremap <leader>nn :.,$g/<C-r>=expand("<cWORD>")<CR>/normal o

" Delete every line which contains the current word
nnoremap <leader>dd :.,$g/<C-r>=expand("<cWORD>")<CR>/d

" Gheto custom autoclose mappings
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Map Ctrl+z/x to decrement/increment
nnoremap <C-z> <C-x>
nnoremap <C-x> <C-a>

" Format JSON in butter using `jq` tool
nmap <leader>jq :%!jq .<cr>

" Set XML formatting for buffer
nmap <leader>xq :set formatexpr=xmlformat#Format()<cr>

" |--------------------------------|
" | End Line Modification Mappings |
" |--------------------------------|

" |--------------------|
" | Begin Tab Mappings |
" |--------------------|

" Map Ctrl-l to go to next tab
noremap <C-l> :<C-U>tabnext<CR>
inoremap <C-l> <C-\><C-N>:tabnext<CR>

" Map Ctrl-h to go to previous tab
noremap <C-h> :<C-U>tabprevious<CR>
" Disabled due to: https://github.com/microsoft/terminal/issues/5957
" Backspace and CTRL+h share the same keycode
"inoremap <C-h> <C-\><C-N>:tabprevious<CR>

" Map Alt-h to go to move this tab to the left
noremap <M-h> :<C-U>-tabmove<CR>
inoremap <M-h> <C-\><C-N>:-tabmove<CR>

" Map Alt-l to go to move this tab to the right
noremap <M-l> :<C-U>+tabmove<CR>
inoremap <M-l> <C-\><C-N>:+tabmove<CR>

" Map Ctrl-n to create a new blank tab
nnoremap <c-n> :tabnew<cr>

" Map [Ctrl-f] Ctrl-k to [force] kill/close the current tab
nnoremap <c-k> :tabc<cr>
nnoremap <c-f><c-k> :tabc!<cr>

" Map Ctrl+w and angle brackets to move window splits (matching Tmux)
nmap <C-w>< <C-w><S-H>
nmap <C-w>> <C-w><S-L>

" Mapping for window vertical resize
nnoremap <C-w><C-x> :vertical resize +5<cr>
nnoremap <C-w><C-z> :vertical resize -5<cr>

" Shortcut to open empty vertical buffer
nmap <leader>vn :vnew<cr>
" Shortcut to open empty horizontal buffer
nmap <leader>sn :new<cr>

" Mappings for opening the native terminal
if has('win32')
    nnoremap <C-s><C-e> :edit term://pwsh<cr>
    nnoremap <C-s><C-n> :tabnew term://pwsh<cr>
    nnoremap <C-s><C-s> :split term://pwsh<cr>
    nnoremap <C-s><C-v> :vsplit term://pwsh<cr>
else
    nnoremap <C-s><C-e> :edit term://zsh<cr>
    nnoremap <C-s><C-n> :tabnew term://zsh<cr>
    nnoremap <C-s><C-s> :split term://zsh<cr>
    nnoremap <C-s><C-v> :vsplit term://zsh<cr>
endif

" Custom map to exit terminal-mode
tnoremap <C-s><C-c> <C-\><C-n>

" |------------------|
" | End Tab Mappings |
" |------------------|

" |---------------------------|
" | Begin Navigation Mappings |
" |---------------------------|

" Shift+dir to jump paragraphs
nnoremap <S-k> <S-{>
nnoremap <S-j> <S-}>
vnoremap <S-k> <S-{>
vnoremap <S-j> <S-}>

" Shift+dir to jump to begin/end of line
nnoremap <S-h> ^
nnoremap <S-l> $
vnoremap <S-h> ^
vnoremap <S-l> $

" Center screen after a Next
nmap n nzz
nmap N Nzz

" Faster scrolling
nnoremap <C-d> 5<C-e>
nnoremap <C-u> 5<C-y>

" Shortcut to the position where the last change was made.
nmap <leader>mm `.
" Shortcut to the first character of the previously changed or YANKED text
nmap <leader>my `[
" Shortcut to the position where the cursor was the last time when INSERT mode was stopped.
nmap <leader>mi `^

" |-------------------------|
" | End Navigation Mappings |
" |-------------------------|

" |----------------------------------|
" | Begin Clipboard/Yanking Settings |
" |----------------------------------|

" Sets the default register to use the "* reg on Windows.
if has('win32')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" |--------------------------------|
" | End Clipboard/Yanking Settings |
" |--------------------------------|

" |----------------------------------|
" | Begin Clipboard/Yanking Mappings |
" |----------------------------------|

" Yank the Name of the current file
nmap <leader>yn :let @+ = expand("%")<cr>

" Alt-e Keybinding for substitute word with yanked register
nmap <M-e> ve"0p

" Alt-p Keybinding for paste yanked register
nmap <M-p> "0p
nmap <M-P> "0P

" Alt-p Keybinding for paste yanked register when in visual mode
vmap <M-p> "0p

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" |--------------------------------|
" | End Clipboard/Yanking Mappings |
" |--------------------------------|

" |-----------------------------------|
" | Begin Search and Replace Settings |
" |-----------------------------------|

" Set the default search to use smartcase
set ignorecase
set smartcase

" Highlight all search matches
set hlsearch
" Highlight all search matches while searching
set incsearch

" |---------------------------------|
" | End Search and Replace Settings |
" |---------------------------------|

" |-----------------------------------|
" | Begin Search and Replace Mappings |
" |-----------------------------------|

" Unhighlight search terms with leader+space
nnoremap <leader><space> :noh<cr>

" Prepare RipGrep with an empty argument without execution
nnoremap <leader>re :Rg

" Prepare Ripgrep with an empty argument but matching whole Word
nnoremap <leader>rw :Rg \b<C-r>=expand("<cword>")<CR>\b
" Prepare search with an empty argument but matching whole word
nnoremap <leader>rs :/\<\>

" RipGrep with the word under the cursor
nnoremap <leader>rg :execute 'Rg ' . expand('<cword>')<Cr>

" RePlace whole word
nnoremap <leader>rr :%s/\<<C-r>=expand("<cword>")<CR>\>/<C-r>=expand("<cword>")<CR>/g
" RePlace word, and fill in substitution (RHS) with current word
nnoremap <leader>rp :%s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/g

" Pull word under cursor into LHS of a substitute (find and replace) in all tabs
nnoremap <leader>trr :tabdo %s#\<<C-r>=expand("<cword>")<CR>\>#
" Same thing, but global within the line and don't match whole word in all tabs
nnoremap <leader>trw :tabdo %s/<C-r>=expand("<cword>")<CR>//g
" RePlace word in all tabs
nnoremap <leader>trp :tabdo %s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/g

" |---------------------------------|
" | End Search and Replace Mappings |
" |---------------------------------|

" |-------------------------|
" | Begin Spelling Mappings |
" |-------------------------|

" Toggle SPell checker
nmap <leader>sp :setlocal spell spelllang=en_us<cr>
nmap <leader>sp :setlocal spell!<cr>

" Spell Complete using the most likely suggestion
nmap <leader>sc 1z=

" Spell Previous
nmap <leader>sa [s
" Spell Next
nmap <leader>sd ]s

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction

" Spell Suggest using fzf
nmap <leader>ss :call FzfSpell()<CR>

" |-----------------------|
" | End Spelling Mappings |
" |-----------------------|

" |------------------------|
" | Begin Custom Functions |
" |------------------------|

function! MarkdownBookmark()
    :s/.*/\L&/g
    :s/\ /-/g
endfunction

" Convert camal case to Java constant style
function! JavaUpperCase()
    :s/\(\u\)/_\1/g
    :s/.*/\U&/g
endfunction

" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
function! Inc(...)
  let result = g:i
    let g:i += a:0 > 0 ? a:1 : 1
      return result
endfunction

" Pull word under cursor into LHS of a increasing number addition
nnoremap <leader>inc :let i = 1<Cr> :%s/\(<C-r>=expand("<cword>")<CR>\)/\=submatch(1) . Inc()/g

" Convert Java constant style to camal case
function! JavaLowerCase()
    :s/.*/\L&/g
    :s/_\(\l\)/\U\1/g
endfunction

" Map java constant case functions to keys
nmap <leader>ju :call JavaUpperCase()<Cr>
nmap <leader>jl :call JavaLowerCase()<Cr>

" |----------------------|
" | End Custom Functions |
" |----------------------|
