" neovim config file by Palexer (init.vim)

" Plugins
" Install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs' " auto close brackets, etc.
Plug 'godlygeek/tabular'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'conornewton/vim-latex-preview'
Plug 'preservim/nerdcommenter'
Plug 'chrisbra/unicode.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

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
set t_Co=256 " force 256 colors
set cursorline!
set lazyredraw
set mouse=a

" leader key
let mapleader = ","

" splits
set splitbelow
set splitright

" Enable folding set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Brackets Highlighting Colors
hi MatchParen cterm=none ctermbg=black ctermfg=white

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

" spell checking
let b:myLang=0
let g:myLangList=["nospell","de_de","en_gb"]
function! ToggleSpell()
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

" toggle language with F7
nmap <silent> <F7> :call ToggleSpell()<CR>

set complete+=kspell

" autocompletion
set completeopt=menuone,longest
set shortmess+=c

" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" navigate autocompletion menu with Tab
inoremap <silent><expr><TAB>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <silent><expr><S-TAB>
    \ pumvisible() ? "\<C-p>" : "\<TAB>"


" Coc
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" go to next/previous error
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

let g:coc_global_extensions = [
  \ 'coc-json', 
  \ 'coc-pyright',
  \ ]

" go to definition, find all references, rename
nmap <F2> <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Go configuration
" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" disable vim-go autocompletion and use coc instead
let g:go_code_completion_enabled = 0

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" NERDTree configuration
" Toggle side window with `CTRL+z`.
map <C-z> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1 " Show hidden files

" hide parts of the default status bar
set noshowmode
set noruler
set noshowcmd
set cmdheight=1

" copy/paste with system clipboard by default
set clipboard+=unnamedplus

" vim-latex-live-preview settings
autocmd Filetype tex setl updatetime=1
let g:latex_pdf_viewer="zathura"
let g:latex_engine="tectonic"

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" sent shortcut
map <F4> :!sent %<CR><CR>

" fzf
map <silent> f :FZF <CR>

" colors
colorscheme onedark
set termguicolors

