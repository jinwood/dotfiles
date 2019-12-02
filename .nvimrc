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

call plug#end()

" --------------------------------
" JavaScript specific stuff


let g:ale_fixers = {'javascript': ['prettier']}
" Fix files automatically on save
let g:ale_fix_on_save = 1

