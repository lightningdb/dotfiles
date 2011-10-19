set nocompatible
set magic
syntax on

let mapleader = ","

set hls
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

" Command-T settings
let g:CommandTMaxHeight = 15
set wildignore+=vendor/rails/**,teamsite/**,spec/fixtures/**

" Visual
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set showmatch " Show matching brackets.
set mat=5     " Bracket blinking.
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
" BUT, turn the above off by default
" need both for vim to start with whitespace and line-endings off
set list
:set list!

" no toolbar, no menu
set guioptions-=T
set guioptions-=m

" os x backspace fix
set backspace=indent,eol,start
fixdel

" tabs -> spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set mouse=a " turn mouse on

" %% expands to the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

let g:yankring_history_dir = '$HOME/.vim'

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

" Don't use Ex mode, use Q for formatting
map Q gq

" #########################
" END BINDINGS
" #########################

" #### From DestroyAllSoftware screencast on file navigation in vim
set winwidth=84 " always have enough width to view file
" ####

let html_use_css=1

filetype off " set up vundle to allow plugin bundling
set runtimepath+=$HOME/.vim/bundle/vundle
call vundle#rc()

Bundle 'vim-scripts/BufOnly.vim'
Bundle 'wincent/Command-T'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/genutils'
Bundle 'vim-scripts/LustyExplorer'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'xaviershay/tslime.vim'
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

" snipmate dependencies
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
"Bundle 'honza/snipmate-snippets'
Bundle 'lightningdb/snipmate-snippets'
Bundle 'lightningdb/vim-snipmate'
source $HOME/.vim/bundle/snipmate-snippets/support_functions.vim

filetype off " set up vundle to allow plugin bundling
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" vimwiki options
let g:vimwiki_list = [{ 'path': '~/vimwiki/' }]
let g:vimwiki_table_auto_fmt=0

"statusline setup
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

set statusline+=%{fugitive#statusline()}

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2


command! Rroutes :R config/routes.rb
command! Rblueprints :R spec/blueprints.rb

nmap <Leader>aa :Tabularize /\|<CR>
vmap <Leader>aa :Tabularize /\|<CR>

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
map <leader>rr :call RunTests('spec')<cr>

set t_Co=256
colorscheme solarized
set background=light
" toggle the background for solarized light or dark
call togglebg#map("<F5>") 

