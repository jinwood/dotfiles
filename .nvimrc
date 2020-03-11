if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'sheerun/vim-polyglot'
Plug 'flowtype/vim-flow'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'prettier/vim-prettier'
" Appearance and Themes
Plug 'agreco/vim-citylights'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'jonathanfilip/lucius'
Plug 'kyoto-shift/film-noir'
Plug 'arzg/vim-corvine'
call plug#end()

" Tabs and spaces
set expandtab " On pressing tab, insert 2 spaces
set tabstop=2 " show existing tab with 2 spaces width
set softtabstop=2
set shiftwidth=2 " when indenting with '>', use 2 spaces width

" Misc

" turn hybrid line numbers on
set number                     " Show current line number
set relativenumber             " Show relative line numbers

set cursorline
set termguicolors
set background=dark
colorscheme corvine
let g:pencil_higher_contrast_ui = 1   " 0=low (def), 1=high
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_bold = 1
set number " Show line numbers
set noswapfile " No swap file
set nobackup
set noswapfile

set textwidth=80
set formatoptions+=t
set colorcolumn=+1
set showmatch
set lazyredraw

" Strip trailing whitespace from all files
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\s\+$//e

" Use the system register for all cut yank and paste operations
set clipboard=unnamedplus

" --------------------------------
" Search
" Ignore node_modules and images from search results
set wildignore+=**/node_modules/**,**/dist/**,**_site/**,*.swp,*.png,*.jpg,*.gif,*.webp,*.jpeg,*.map

" --------------------------------
"  Coc
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" --------------------------------
"  Ale

let g:ale_sign_error = '💩'
let g:ale_sign_warning = '⚠️'
highlight clear ALEWarningSign
highlight clear ALEErrorSign

" --------------------------------
"  Custom keymaps

nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

nnoremap <C-p> :Files<CR>
" <Leader> default \
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" Search Tags
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" --------------------------------
" JavaScript specific stuff


let g:ale_fixers = {'javascript': ['prettier']}
" Fix files automatically on save
let g:ale_fix_on_save = 1
let g:javascript_plugin_flow = 1



