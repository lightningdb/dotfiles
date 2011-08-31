set nocompatible
set magic
syntax on

let mapleader = ","

set nohls
set incsearch
set showcmd

set hidden
set wildmenu
set autoread
set nobackup
set nowritebackup
set smartindent
set gdefault
set cursorline
set nu     " Line numbers on
set nowrap " Line wrapping off
set directory=/tmp

" need both of these for vim to startup with whitespace and line-endings
" switched off
set list
:set list!

" set to use 'par' for formatting
set formatprg=par\ -w72qrg

" Command-T settings
let g:CommandTMaxHeight = 15
set wildignore+=vendor/rails/**,teamsite/**

" Visual
set showmatch " Show matching brackets.
set mat=5     " Bracket blinking.
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" no toolbar, no menu
set guioptions-=T
set guioptions-=m

" os x backspace fix
set backspace=indent,eol,start
"set t_kb
fixdel

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" turn mouse on
set mouse=a

" %% expands to the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

" #########################
" BINDINGS
" #########################
nnoremap <leader><leader> <c-^>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

map <leader>q :BufO<CR>

map <leader>f :Ack<space>
" A function to search for word under cursor, using Ack plugin
function! SearchWord()
   normal "zyiw
   exe ':Ack '.@z
endfunction
map <leader>F :call SearchWord()<CR>

" space = pagedown, - = pageup
noremap <Space> <PageDown>
noremap - <PageUp>

nnoremap <F2><F2> :vsplit<CR>
nnoremap <F4><F4> :set invwrap wrap?<CR>  " use f4f4 to toggle wordwrap
nnoremap <F5><F5> :set invhls hls?<CR>    " use f5f5 to toggle search hilight

" Yankring Show
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

map <C-t> <Esc>:%s/[ ^I]*$//<CR>:retab<CR> " remove trailing space and retab

nmap <leader>s :source ~/.vimrc<CR>
nmap <leader>v :e ~/.vimrc<CR>

nnoremap <leader>d :NERDTreeToggle<CR>

nmap <S-H> :BufSurfBack<CR>
nmap <S-L> :BufSurfForward<CR>

" CTags
map <Leader>rt :!ctags --extra=+f --exclude=teamsite --exclude=public -R *<CR><CR>

" Flush Command T (rescans directories)
map <Leader>tf :CommandTFlush<CR>
map <Leader>t :CommandT<CR>

" Toggle off whitespace highlighting
map <Leader>w :set list!<CR>

" #########################
" END BINDINGS
" #########################

" #### From DestroyAllSoftware screencast on file navigation in vim
set winwidth=84 " always have enough width to view file
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
"set winheight=5
"set winminheight=5
"set winheight=999
" ####

let html_use_css=1

filetype off " set up vundle to allow plugin bundling
set runtimepath+=~/home/vim/bundle/vundle
call vundle#rc()

Bundle 'vim-scripts/BufOnly.vim'
Bundle 'wincent/Command-T'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/genutils'
Bundle 'vim-scripts/LustyExplorer'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/tslime.vim'
Bundle 'Townk/vim-autoclose'
Bundle 'slack/vim-bufexplorer'
Bundle 'ton/vim-bufsurf'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'wgibbs/vim-irblack'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/vimwiki'
Bundle 'gmarik/vundle'

filetype off " set up vundle to allow plugin bundling
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

let g:snippets_dir='~/home/vim/bundle/snipmate-snippets,~/home/vim/ldb-snippets'

" vimwiki options
let g:vimwiki_list = [{ 'path': '~/vimwiki/', 'ext': '.txt' }]

command! Rroutes :Redit config/routes.rb
command! Rblueprints :Redit spec/blueprints.rb

if exists(":Tabularize")
  nmap <Leader>a\= :Tabularize /=<CR>
  vmap <Leader>a\= :Tabularize /=<CR>
  nmap <Leader>a\: :Tabularize /:\zs<CR>
  vmap <Leader>a\: :Tabularize /:\zs<CR>
  nmap <Leader>a\| :Tabularize /\|<CR>
  vmap <Leader>a\| :Tabularize /\|<CR>
endif

" #### From DestroyAllSoftware screencast on file navigation in vim
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!bundle exec spec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:ldb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:ldb_test_file")
        return
    end
    call RunTests(t:ldb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>r :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>R :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

set t_Co=256
colorscheme solarized
set background=light
" toggle the background for solarized light or dark
call togglebg#map("<F5>") 

