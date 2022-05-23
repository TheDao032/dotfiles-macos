"  SET OUT STUFF
" -----------------------
set nocompatible
filetype plugin indent on
syntax on


set modeline
set nowrap
set hidden
set number relativenumber
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set autoindent
set clipboard=unnamedplus
set shell=/bin/zsh
set pastetoggle=<F2>
set scrolloff=3

set encoding=UTF-8
set mouse=a 
set tabstop=4 
set softtabstop=0
set shiftwidth=4

set undodir=~/.vim/undodir
set undofile
set foldmethod=syntax 
set directory=.,$TEMP
set pyxversion=3
set tags=./tags,tags

let mapleader = " "

" Plug-Ins Installation via vim-plug
" -------------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Plug 'vimwiki/vimwiki'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'machakann/vim-highlightedyank' 
Plug 'eslint/eslint'
Plug 'palantir/tslint'
Plug 'editorconfig/editorconfig-vim'
Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
Plug 'morhetz/gruvbox'
Plug 'turbio/bracey.vim'
" Plug 'shushcat/vim-minimd'
" Plug 'rlue/vim-barbaric'
" Plug 'dkarter/bullets.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'BurntSushi/ripgrep'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'ihsanturk/neuron.vim'
Plug 'SidOfc/mkdx'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'herringtondarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier'
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'burnettk/vim-angular'
Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'
Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
" Plug 'liuchengxu/vim-which-key'
" Plug 'plasticboy/vim-markdown' 

call plug#end()

" THEME
colorscheme gruvbox

" ------------------------------ 
" KEY BIDDINGS / KEY MAPPINGS
" ------------------------------ 
map Y y$"
inoremap <C-U> <C-G>u<C-U>
nnoremap <Leader>g :Goyo<CR>
noremap <Leader>w :set wrap!<CR>
" Files Opened History
noremap <C-h> :History<CR>
" Find And Open Files
noremap <C-p> :Files<CR>
" noremap <Leader>no :lcd ~/notes<CR>:Rg<CR>
" Clear Searching
noremap <C-l> :noh<CR><C-L>
" Ripgrep (Search File By Words)
noremap <leader>/ :Rg<CR>
" Open Folder Tree
noremap <leader>. :NERDTreeToggle<CR>
" Configure for Python development
let g:pymode_run_bind='<F1>'
let g:pymode_run_bind='<F3>'
let g:pymode_run_bind='<F4>'
let g:pymode_run_bind='<F5>'
" apollo project (kaypay)
" install package via poetry
noremap <F1> <C-[>:w<CR>:!cd ./services/src && poetry install<CR>
" apollo services test
noremap <F3> <C-[>:w<CR>:!cd ./services/src/app/tests/integration && poetry run pytest -vv<CR>
" apollo services start
noremap <F4> <C-[>:term<CR>icd ./services/src && poetry run uvicorn app.main:app --reload<CR><C-\><C-n>m<S-a>
" noremap <F4> <C-[>:w<CR>:!python3 %<CR>
" noremap <F5> <C-[>:term<CR>isudo /odoo/odoo-server/start.sh<CR><C-\><C-n>m<S-a>

" nodemon starting
" let g:pymode_run_bind='<F2>'
" noremap <F2> <C-[>:term<CR>i nodemon app<CR><C-\><C-n>m<S-q>

" ng serve starting
" let g:pymode_run_bind='<F3>'
" noremap <F3> <C-[>:term<CR>i ng serve<CR><C-\><C-n>m<S-w>

" Fold Configure
" FoldOpen noremap
noremap <Leader>fn :foldopen<CR>
" FoldClose noremap
noremap <Leader>fe :foldclose<CR>

" For Emacs-style editing on the command-line: >
" --------------------------------------------
" start of line
cnoremap <C-A>		<Home>
" back one character
cnoremap <C-B>		<Left>
" delete character under cursor
cnoremap <C-D>		<Del>
" end of line
cnoremap <C-E>		<End>
" forward one character
cnoremap <C-F>		<Right>
" recall newer command-line
cnoremap <C-N>		<Down>
" recall previous (older) command-line
cnoremap <C-P>		<Up>
" back one word
cnoremap <Esc><C-B>	<S-Left>
cnoremap <M-b> <S-Left>
" forward one word
cnoremap <Esc><C-F>	<S-Right>
cnoremap <M-f> <S-Right>

" Readline in insertmode
inoremap <c-a> <c-o>0
inoremap <c-e> <c-o>$

" function! HandleURL()
"   let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
"   echo s:uri
"   if s:uri != ""
"     silent exec "!open '".s:uri."'"
"   else
"     echo "No URI found in line."
"   endif
" endfunction
" map <leader>u :call HandleURL()<cr>

" AUTOCOMMANDS
" ---------------------
" NOTE: Don't know why this not work with my NeoVim
" augroup highlight_yank
"     autocmd!
"     autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
" augroup END

augroup TerminalStuff
	autocmd!
	autocmd TermEnter * setlocal nonumber norelativenumber
	autocmd TermLeave * setlocal number relativenumber
augroup END

" PLUG-INS CONFIGURATION
" ------------------------- 

let g:clipboard = {
          \   'name': 'myClipboard',
          \   'copy': {
          \      '+': {lines, regtype -> extend(g:, {'foo': [lines, regtype]}) },
          \      '*': {lines, regtype -> extend(g:, {'foo': [lines, regtype]}) },
          \    },
          \   'paste': {
          \      '+': {-> get(g:, 'foo', [])},
          \      '*': {-> get(g:, 'foo', [])},
          \   },
          \ }

" let g:clipboard = {
"           \   'name': 'myClipboard',
"           \   'copy': {
"           \      '+': ['tmux', 'load-buffer', '-'],
"           \      '*': ['tmux', 'load-buffer', '-'],
"           \    },
"           \   'paste': {
"           \      '+': ['tmux', 'save-buffer', '-'],
"           \      '*': ['tmux', 'save-buffer', '-'],
"           \   },
"           \   'cache_enabled': 1,
"           \ }

let g:highlightedyank_highlight_duration = 250

let g:netrw_preview = 1
" let g:vimwiki_list = [{ 'path': '~/notes/', 'syntax':'markdown', 'ext': '.md' }]
let g:vim_markdown_folding_disabled = 1
set conceallevel=2

let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 0 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 0 },
						\ 'tokens': { 'list': '*' },
						\ 'gf_on_steroids': 1 }

nmap <Plug> <Plug>(mkdx-text-italic-n)
vmap <Plug> <Plug>(mkdx-text-italic-v)

" --------
" Setup my notes within vim
" ----------
" let notesdir= "~/notes"
" autocmd FileType markdown setl suffixesadd+=.md

" WSL yank support
" let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path

" auto-sync notes
" augroup auto_sync_notes
" 	autocmd!
" 	autocmd BufWritePost ~/notes/* !cd ~/notes;git add "%";git commit -m "Auto commit of %:t." "%";git push origin master
" augroup END

" Sync notes after entering Vim
" augroup pull_notes
" 	autocmd!
" 	autocmd VimEnter ~/notes/* !cd ~/notes;git pull origin master
" augroup END

" if executable(s:clip)
"     augroup WSLYank
"             autocmd!
"             autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"     augroup END
" endif

" ----------------------------------------------------------------------------
"  goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
 " Color name (:help cterm-colors) or ANSI code
 let g:limelight_conceal_ctermfg = 'gray'
 let g:limelight_conceal_ctermfg = 240

 " Color name (:help gui-colors) or RGB color
 let g:limelight_conceal_guifg = 'DarkGray'
 let g:limelight_conceal_guifg = '#777777'

 " Default: 0.5
 let g:limelight_default_coefficient = 0.7

 " Number of preceding/following paragraphs to include (default: 0)
 let g:limelight_paragraph_span = 1

 " Beginning/end of paragraph
 "   When there's no empty line between the paragraphs
 "   and each paragraph starts with indentation
 let g:limelight_bop = '^\s'
 let g:limelight_eop = '\ze\n^\s'

 " Highlighting priority (default: 10)
 "   Set it to -1 not to overrule hlsearch
 let g:limelight_priority = -1

 " Python Provider Path
 let g:python_host_prog  = '/usr/bin/python'
 let g:loaded_python_provider = 0

 " Perl Provider Path
 let g:perl_host_prog = '/usr/bin/perl'
 let g:loaded_perl_provider = 1

 " Ruby Provider Path
 let g:ruby_host_prog = '/usr/bin/ruby'

 " Python3 Provider Path
 let g:python3_host_prog = '/usr/bin/python3'
 let g:loaded_python6_provider = 1

 " NERDTreeToggle Configure
 let g:NERDTreeWinSize = 50

 let g:loaded_node_provider = 0

 function! s:goyo_enter()
 	set noshowmode
 	set noshowcmd
 	set scrolloff=999
 	Limelight
 	" set background=light
 	set linespace=7
 	set wrap
 	" Limelight
 	let &l:statusline = '%M'
 	hi StatusLine ctermfg=red guifg=red cterm=NONE
 endfunction

 function! s:goyo_leave()
 	set showmode
 	set showcmd
 	set scrolloff=5
 	Limelight!	
  	" set background=dark
 	set linespace=0
 	set nowrap
 	" Limelight!
 endfunction

 autocmd! User GoyoEnter nested call <SID>goyo_enter()
 autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Configure for Python
" ---------------------
autocmd BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

autocmd BufRead *.sql
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
" FZF notes
" command! -bang -nargs=* Find
"   \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"
" command! -bang -nargs=* Find call fzf#vim#grep('rg --vimgrep --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)
"
" Coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-tslint', 
  \ 'coc-prettier', 
  \ 'coc-go', 
  \ 'coc-vetur', 
  \ 'coc-python', 
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-emmet',
  \ 'coc-marketplace',
  \ 'coc-html',
  \ 'coc-jedi'
  \ ]

" Prettier Command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

if !exists('g:vscode')
endif
