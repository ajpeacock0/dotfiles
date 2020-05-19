set nocompatible

let g:has_async = v:version >= 800 || has('nvim')

" |------------------------|
" | Begin Plugin Functions |
" |------------------------|

" Use with Plug to conditionally load plugins
" This allows the plugin to be registered even if not used, to prevent
" potential removal
function! PlugEnableIf(condition, ...)
    let opts = get(a:000, 0, {})
    return a:condition ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Checks whether a given Python module is installed
function! HasPythonModule(name)
    let l:hasModule = 0
    if has('pythonx')
pythonx << moduleCheck
import vim, pkgutil
if pkgutil.find_loader(vim.eval("a:name")):
    vim.command("let l:hasModule = 1")
moduleCheck
    endif
    return l:hasModule
endfunction

" |------------------------|
" | End Plugin Functions |
" |------------------------|

" |-------------------|
" | Begin Plugin List |
" |-------------------|

" Ensure VimPlug is installed
" This is disabled on Windows since curl doesn't use '~'
if !has('win32') && empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Autocompletion Plugin and depencencies
Plug 'ncm2/ncm2', PlugEnableIf(HasPythonModule('neovim'))
Plug 'roxma/nvim-yarp', PlugEnableIf(HasPythonModule('neovim'))
Plug 'roxma/vim-hug-neovim-rpc', PlugEnableIf(HasPythonModule('neovim'))

" Completion Sources
Plug 'ncm2/ncm2-bufword', PlugEnableIf(HasPythonModule('neovim'))
Plug 'Shougo/neco-vim', PlugEnableIf(HasPythonModule('neovim'))
Plug 'ncm2/ncm2-vim', PlugEnableIf(HasPythonModule('neovim'))

" ControlP (requires fzf installed)
Plug 'tacahiroy/ctrlp-funky'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Theme Plugin
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'

" Side windows displaying buffers
Plug 'jeetsukumaran/vim-buffergator'

" Improve the `.` command to include macros, plugin maps, etc.
Plug 'tpope/vim-repeat'

" Switch between source and header
Plug 'vim-scripts/a.vim'

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

" CTags manager
Plug 'ludovicchabant/vim-gutentags', PlugEnableIf(executable('ctags'))

" Show information about files in a git repo
Plug 'airblade/vim-gitgutter'

" Markdown syntax highlighting
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" EOL whitespace removal
Plug 'ntpeters/vim-better-whitespace'

" Formatting Markdown tables
Plug 'dhruvasagar/vim-table-mode'

" Initialize plugin system
call plug#end()

" Enable ncm2 for all buffers. If the python module check
" for neovim failed, ensure `pip3 install --user pynvim`
if HasPythonModule('neovim')
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=noinsert,menuone,noselect
endif

" Make the backspace + delete work like in most other programs
set backspace=indent,eol,start

" |-----------------|
" | End Plugin List |
" |-----------------|

" |-----------------------|
" | Begin Plugin Settings |
" |-----------------------|

" Needed in Linux Shell to send <Alt+j/k> for the `vim-move` plugin
if !has('win32')
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-h>=\eh"
    execute "set <M-l>=\el"
endif

if (executable('fzf'))
    " Remap CtrlP mappings to FZF
    nnoremap <c-p> :Files<Cr>
    " Run Fzf and open buffer in new tab
    nnoremap <c-o> :call fzf#run({'sink': 'tabedit', 'options': '--multi --no-mouse', 'down': '40%'})<Cr>
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
colorscheme jellybeans

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

" Note: `set termguicolors` fixes Powershell colors, but causes significant UI glitches
if &t_Co == 16
    " TODO: Set a improved 16 color supported theme
endif

if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:tmuxline_preset = 'tmux'
endif

" |------------------|
" | End GUI Settings |
" |------------------|

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

" Alias for :A (switching source/header with a.vim)
nnoremap <leader>a :A<Cr>

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

" Shortcut for Yes/No for enabling paste mode
nnoremap <leader>py :set paste<Cr>
nnoremap <leader>pn :set nopaste<Cr>

" Shortcut for Yes/No for enabling diff mode
nnoremap <leader>dy :windo diffthis<Cr>
nnoremap <leader>dn :windo diffoff<Cr>

" |----------------------|
" | End General Mappings |
" |----------------------|

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

" Change all the existing tab characters to match the current tab settings
nmap <leader>tab :set et<cr> :ret!<cr>

" From the current line to EOF, insert new line for each match of the cursor WORD
nnoremap <leader>nn :.,$g/<C-r>=expand("<cWORD>")<CR>/normal o

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
inoremap <C-h> <C-\><C-N>:tabprevious<CR>

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

" Keybinding for substitute word with yanked register
nmap <leader>pe ve"0p
" Keybinding for paste yanked register
nmap <leader>p "0p
" Keybinding for paste yanked register behind
nmap <leader>P "0P
" Keybinding for paste yanked register when in visual mode
vmap <leader>p "0p

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

" Set search to very-magic
nnoremap / /\v
cnoremap %s/ %s/\v

" Prepare RipGrep with an empty argument without execution
nnoremap <leader>re :Rg

" RipGrep with the word under the cursor
nnoremap <leader>rg :execute 'Rg ' . expand('<cword>')<Cr>

" Pull word under cursor into LHS of a substitute (find and replace)
nnoremap <leader>rr :%s#\<<C-r>=expand("<cword>")<CR>\>#
" Same thing, but global within the line and don't match whole word
nnoremap <leader>rw :%s/<C-r>=expand("<cword>")<CR>//g
" RePlace word
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
nmap <leader>sn [s
" Spell Next
nmap <leader>sm ]s

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

nmap <leader>mb :call MarkdownBookmark()<Cr>

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

" |------------------------------------------|
" | Begin Tag, swap and backup file settings |
" |------------------------------------------|

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" Get null output stream path based on platform
function! DevNullPath()
    if has('win32')
	return 'NUL'
    else
	return '/dev/null'
    endif
endfunction

" Creates the given directory if it doesn't exist
function! EnsureDirectory(path)
    let a:expandedPath = expand(a:path)
    let a:devNull = DevNullPath()
    if empty(glob(a:expandedPath))
	:silent execute '!mkdir -p ' . a:expandedPath . ' > ' . a:devNull . ' 2>&1'
    endif
endfunction

" Enable persistent undo, and put undo files in their own directory to prevent
" pollution of project directories
if has('persistent_undo')
    call EnsureDirectory('~/.vim/undo')
    " Remove current directory and home directory, then add .vim/undo as main
    " dir and current dir as backup dir
    set undodir-=.
    set undodir-=~/
    set undodir+=.
    set undodir^=~/.vim/undo//
    set undofile
endif

" Move swap files and backup files to their own directory to prevent pollution
call EnsureDirectory('~/.vim/backup')
" Remove current directory and home directory, then add .vim/backup as main dir
" and current dir as backup dir
set backupdir-=.
set backupdir-=~/
set backupdir+=.
set backupdir^=~/.vim/backup//
" Enable standard backups if not built with 'writebackup'
if !has('writebackup')
    set backup
endif

call EnsureDirectory('~/.vim/swap')
" Remove current directory and home directory, then add .vim/swap as main
" dir and current dir as backup dir
set directory-=.
set directory-=~/
set directory+=.
set directory^=~/.vim/swap//
set swapfile

" |------------------------------------------|
" | End Tag, swap and backup file settings |
" |------------------------------------------|

