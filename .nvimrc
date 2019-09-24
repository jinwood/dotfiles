call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-gitgutter'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'altercation/vim-colors-solarized'

  " Enable `gf` on `require()` calls
  Plug 'moll/vim-node', { 'for': 'javascript' }

  " javascript related completions and syntaxes
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

  " typescript related completions and syntaxes
  Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

  " json syntax highlighting
  Plug 'elzr/vim-json', { 'for': 'json' }

  " markdown syntax highlighting
  Plug 'tpope/vim-markdown'

  " html syntax highlighting
  Plug 'othree/html5.vim', { 'for': 'html' }

  " css syntax highlighting
  Plug 'hail2u/vim-css3-syntax', { 'for': [ 'css', 'scss' ] }

  " liquid template (jekyll) syntax highlighting
  Plug 'tpope/vim-liquid', { 'for': ['html', 'md', 'liquid' ] }

call plug#end()


augroup fzfSettings
  nmap <C-p> :GFiles<cr>
  nmap <C-o> :Files<cr>
  nmap <C-t> :Buffers<cr>
  nmap <leader>/ :Ag<cr>
  nmap <leader>d :call fzf#vim#tags('^' . expand('<cword>'), {'options': '--exact --select-1 --exit-0 +i'})<CR>
  nmap <leader>g :Ag <c-r>=expand("<cword>")<CR><CR>
  let g:fzf_nvim_statusline = 0
  autocmd! FileType fzf
  autocmd FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
augroup END

augroup aleSettings
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
  nmap <silent> gd :ALEGoToDefinition<CR>
  let g:ale_set_loclist = 0
  let g:ale_set_quickfix = 1
  let g:ale_sign_column_always = 1
  let g:ale_sign_error = ''
  let g:ale_sign_warning = ''
  " let g:ale_fix_on_save = 1
  let g:ale_fixers = {
  \   'javascript': ['remove_trailing_lines', 'trim_whitespace', 'eslint'],
  \}
  let g:ale_linters = {
  \   'javascript': ['eslint', 'flow', 'tsserver'],
  \}
augroup END

augroup airlineSettings
  let g:airline_extensions = ['tabline']
  let g:airline#extensions#tabline#show_splits = 1
  let g:airline#extensions#tabline#buffers_label = '*'
  " let g:airline#extensions#tabline#formatter = 'custom'
  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1
  " let g:airline_section_a = ''
  let g:airline_section_b = ''
  let g:airline_section_c = ' '
  let g:airline_section_x = '%f:%3l:%2v'
  let g:airline_section_y = ''
  let g:airline_section_z = ''
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " dont show expected file format
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
  set noshowmode " disable vim's default mode line (e.g. `--INSERT--`)
augroup END

augroup cocSettings
  " Enter expands snippets
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<tab>"
  nmap <Leader>o :CocList outline<cr>
augroup end

augroup javascriptSyntaxSettings
  let g:javascript_plugin_jsdoc = 1
  let g:javascript_plugin_flow = 1
  let g:vim_json_syntax_conceal = 0
augroup end

""" Syntaxes

" settings
set hidden                           " allow changing buffers even if existing buffer has changes
set list                             " show hidden characters
set ignorecase                       " search case insensitive by default
set nocompatible                     " disable backwards compat features
set mouse=a                          " enable mouse support
set number                           " enable line numbers
set nowrap                           " disable line wrapping
set ts=2 sts=2 sw=2 et               " make tabs 2 spaces, but use softtabs
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1  " attempt to make things true-color
set lazyredraw                       " attempt to speed up redrawing
set ttyfast                          " attempt to speed up redrawing
set nofoldenable                     " disable annoying folding
set inccommand=nosplit               " enable inccommand
set fillchars+=vert:│

if has('autocmd')
  augroup syntaxes
    autocmd!
    autocmd BufNewFile,BufReadPost git-rebase-todo set filetype=gitrebase
    autocmd BufNewFile,BufReadPost gitconfig set filetype=gitconfig
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.flow set filetype=javascript
    autocmd BufNewFile,BufRead *.ts  set filetype=typescript
    autocmd BufNewFile,BufReadPost tigrc set filetype=vimrc
    autocmd BufNewFile,BufReadPost Vagrantfile set filetype=ruby
  augroup END
end

" extra keybindings
vnoremap . :normal .<CR>
nnoremap <esc> :

" markdown settings
let g:markdown_fenced_languages = ['ruby', 'erb=ruby', 'sh', 'yaml', 'javascript', 'js=javascript', 'json=javascript', 'html', 'css', 'sass']
let g:markdown_syntax_conceal = 0
" When in markdown, having selected some text, press Ctrl+K to have it wrapped
" in [](). So `foo` becomes `[foo]()` with the cursor placed inbetween ()
xmap <C-k> "zdi[<C-R>z]()<Left>

augroup colorSettings
  set t_Co=256
  set background=light
  colorscheme solarized
  augroup noBackground
    hi Normal guibg=NONE ctermbg=NONE
    hi NonText guibg=NONE ctermbg=NONE
    hi LineNr guibg=NONE ctermbg=NONE
  augroup end
  if &background ==# "dark"
    let g:airline_theme = 'wombat'
    let g:indentLine_color_term = 240
    hi Normal guibg=#000000
    hi NonText ctermfg=240
    hi SpecialKey ctermfg=240
    hi Search cterm=NONE ctermfg=NONE ctermbg=240
    hi CursorLineNr ctermfg=250
  else
    let g:airline_theme = 'solarized'
    let g:indentLine_color_term = 254
    hi NonText ctermfg=250
    hi SpecialKey ctermfg=254
    hi Search cterm=NONE ctermfg=NONE ctermbg=254
    hi CursorLineNr ctermfg=3
  endif
augroup END

