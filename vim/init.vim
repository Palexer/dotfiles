" neovim config file by Palexer (init.vim)
" general
filetype plugin indent on
set number
syntax on
set encoding=utf-8
set smartindent
set tabstop=4
set shiftwidth=4
set nowrap
set nu
set noswapfile
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set background=dark
set noerrorbells
set backspace=indent,eol,start

" splits
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" colors
colorscheme onedark
set termguicolors

" Brackets Highlighting Colors
hi MatchParen cterm=none ctermbg=black ctermfg=white

" Errors/BadSpellings Higlighing Colors
:highlight clear SpellBad

" status bar
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           		" buffer number
set statusline+=%#Visual#       		" colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     		" colour
set statusline+=%R                      " readonly flag
set statusline+=%M                      " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     		" colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                      " right align
set statusline+=%#CursorLine#   		" colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     		" colour
set statusline+=\ %3l:%-2c\         	" line + column
set statusline+=%#Cursor#       		" colour
set statusline+=\ %3p%%\                " percentage

" autocomplete: 
" don't complete words from kspell dictionary
set complete+=kspell

set completeopt=menuone,longest
set shortmess+=c

" ale
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
 \ 'go': ['gopls'],
\} 


" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Plugins
" Install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs' " auto close brackets, etc.
Plug 'joshdick/onedark.vim' " colorscheme
Plug 'vim-scripts/AutoComplPop'
Plug 'godlygeek/tabular'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Go configuration
" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_code_completion_enabled = 0

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" automatically open autocompletion menu when a dot appears
au filetype go inoremap <buffer> . .<C-x><C-o>

" NERDTree configuration
" Toggle side window with `CTRL+z`.
map <C-z> :NERDTreeToggle<CR> 
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1 " Show hidden files

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" hide parts of the default status bar
set noshowmode
set noruler
set noshowcmd
set cmdheight=1

" copy/paste with system clipboard by default
set clipboard+=unnamedplus

