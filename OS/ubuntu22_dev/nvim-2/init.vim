"set nocompatible              " required
"
"" let Vundle manage Vundle, required
call plug#begin('~/.vim/plugged')
"
"" add all your plugins here (note older versions of Vundle
"" used Bundle instead of Plugin)
"
"" Code folding with SimpylFold
Plug 'tmhedberg/SimpylFold' " code folding
Plug 'vim-syntastic/syntastic' " Syntax checking
Plug 'nvie/vim-flake8' " static syntax and style checker for python
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive' " Git support
Plug 'rbong/vim-flog' " Git support
Plug 'tpope/vim-obsession'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"
"" Color schemes
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
"
"" Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"" Plug 'vim-scripts/indentpython.vim'	" PEP 8 conforming autoindent;
"" Plug 'tpope/vim-obsession'
"
"" All of your Plugins must be added before the following line
call plug#end()            " required
"filetype plugin indent on    " required

" Source other rc files first
source ~/.config/nvim/coc_example.vim

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za
" See docstrings for folded code
let g:SimpylFold_docstring_preview=1

" Enable python 3 syntastic executable
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']

" General styling
set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79
set hlsearch
hi Search ctermbg=LightYellow
hi Search ctermfg=Red
hi Visual cterm=bold 
hi Visual ctermbg=Yellow 
hi Visual ctermfg=Red

" PEP 8 Styling
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79
au BufNewFile,BufRead *.py set expandtab autoindent fileformat=unix

" C++ Styling
au BufNewFile,BufRead *.c,*.cpp,*.h,*.C,*.H set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79
au BufNewFile,BufRead *.c,*.cpp,*.h,*.C,*.H set expandtab autoindent fileformat=unix

" html Styling
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79
au BufNewFile,BufRead *.html set expandtab autoindent fileformat=unix

"  ini Styling
au BufNewFile,BufRead *.ini set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79
au BufNewFile,BufRead *.ini set expandtab autoindent fileformat=unix filetype=dosini

" Encoding
set encoding=utf-8

" Line numbering
set nu

" Full stack development styling (somethnig is wrong here, but not for now)
au BufNewFile,BufRead *.js,*.html,*.css set tabstop=2 softtabstop=2 shiftwidth=2

" Flagging unnecessary whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"" python with virtualenv support
"py3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

" Syntax pretty
let python_highlight_all=1
syntax on

" Choose which color scheme to use
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Allow color change with F5 with GUI
" call togglebg#map("<F5>")

" Hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" NERDTree Shortkeys
nnoremap <leader>n :NERDTreeFocusToggle<CR>
nnoremap <C-n> :NERDTreeTabsOpen<CR>
nnoremap <C-t> :NERDTreeTabsToggle<CR>
nnoremap <C-f> :NERDTreeTabsFind<CR>

" Auto-complete
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
						\ pumvisible() ? "\<C-n>" :
						\ <SID>check_back_space() ? "\<Tab>" :
						\ coc#refresh()
" use <c-space> for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" to make <cr> select the first completion item and confirm the completion when
" no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

