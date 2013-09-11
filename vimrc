" .vimrc
"
" Author: Dave Bolton <dave@davebolton.net>
" Source: http://github.com/lightningdb/dotfiles/blob/master/vimrc

set nocompatible
set magic
set shortmess+=I
syntax on

let mapleader = ","
let maplocalleader = "\\"

set hls
set incsearch
set showcmd

set hidden
set wildmenu
set autoread
set title
set nobackup
set nowritebackup
set smartindent
set gdefault
set ttyfast
set ruler
set history=500
set cursorline
set nu     " Line numbers on
set nowrap " Line wrapping off
set directory=/tmp

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

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set mouse=a " turn mouse on

set virtualedit+=block

" Save when losing focus
au FocusLost * :wa

" %% expands to the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

let g:yankring_history_dir = '$HOME'
let g:yankring_manual_clipboard_check = 0
let g:yankring_replace_n_pkey = '<C-y>'
"let g:yankring_replace_n_nkey = '<C-y>'
let g:yankring_n_keys = 'Y D'

let g:ycm_key_detailed_diagnostics = ''

let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
let g:UltiSnipsExpandTrigger="<F3>"
let g:UltiSnipsListSnippets="<c-F3>"
let g:UltiSnipsJumpForwardTrigger="<F3>"
let g:UltiSnipsJumpBackwardTrigger="<s-F3>"

let g:session_autoload = 'no'

let g:vimwiki_hl_headers = 1

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:airline_enable_fugitive=1

" #########################
" BINDINGS
" #########################
nnoremap <leader><leader> <c-^>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
noremap j gj
noremap k gk

nnoremap <CR> o<ESC>
" don't use above mapping of CR for newline in quickfix window
augroup quickfix
  autocmd!
  au BufReadPost quickfix nnoremap <CR> <CR>
augroup END

nnoremap .. '.zz

noremap <leader>q :BufO<CR>

" A function to search for word under cursor, using Ack plugin
function! SearchWord()
   normal "zyiw
   exe ':Ack! '.@z
endfunction
noremap <leader>f :Ack!<space>
noremap <leader>F :call SearchWord()<CR>

" space = pagedown, - = pageup
noremap <Space> <PageDown>
noremap - <PageUp>

nnoremap <F2><F2> :vsplit<CR>
nnoremap <F4><F4> :set invwrap wrap?<CR>  " use f4f4 to toggle wordwrap
nnoremap <F5><F5> :set invhls hls?<CR>    " use f5f5 to toggle search hilight

" Yankring Show
nnoremap <silent> <F2> :YRShow<cr>
inoremap <silent> <F2> <ESC>:YRShow<cr>

noremap <C-t> <Esc>:%s/[ ^I]*$//<CR>:retab<CR> " remove trailing space and retab

nnoremap <leader>sv :source ~/.vimrc<CR>
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j<C-w>L:e ~/.vim/bundle/Ultisnips-snippets/snippets<cr>

nnoremap <leader>d :NERDTreeToggle<CR>

nnoremap <S-H> :BufSurfBack<CR>
nnoremap <S-L> :BufSurfForward<CR>

" Faster Esc
inoremap jk <esc>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" CTags
noremap <Leader>rt :!ctags --extra=+f --exclude=teamsite --exclude=public -R *<CR><CR>

" Toggle off whitespace highlighting
noremap <Leader>w :set list!<CR>

" Don't use Ex mode, use Q for formatting
noremap Q gq

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

noremap <leader>vo :VimwikiIndex<cr>:VimwikiGoto
noremap <leader>mi :VimwikiIndex<cr>:VimwikiGoto MyInbox<cr>
nmap <leader>xx <Plug>VimwikiToggleListItem

noremap <leader>tt :read !task today<cr>

noremap <leader>ops :OpenSession inbox_and_goals_and_diary<cr>

" #########################
" END BINDINGS
" #########################

" vimwiki options
let g:vimwiki_list = [{ 'path': '~/vimwiki/' }]
let g:vimwiki_table_auto_fmt=0
let g:vimwiki_table_mappings=0
let g:vimwiki_use_calendar=1
"let g:vimwiki_debug=1

" #### From DestroyAllSoftware screencast on file navigation in vim
set winwidth=84 " always have enough width to view file
" ####

let html_use_css=1

filetype off " set up vundle to allow plugin bundling
set runtimepath+=$HOME/.vim/bundle/vundle
call vundle#rc()

Bundle 'vim-scripts/BufOnly.vim'
Bundle 'vim-scripts/calendar.vim--Matsumoto'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/genutils'
Bundle 'vim-scripts/LustyExplorer'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'ton/vim-bufsurf'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'wgibbs/vim-irblack'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'vim-ruby/vim-ruby'
Bundle 'derekwyatt/vim-scala'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/vimwiki'
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Raimondi/delimitMate'
"Bundle 'xolox/vim-session'
Bundle 'terryma/vim-expand-region'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'bling/vim-airline'
Bundle 'Shougo/unite.vim'

Bundle 'SirVer/ultisnips'
Bundle 'lightningdb/UltiSnips-snippets'

" For debugging colorschemes
"Bundle 'gerw/vim-HiLinkTrace'
"Bundle 'vim-scripts/hexHighlight.vim'

filetype off " set up vundle to allow plugin bundling
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

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

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1        

command! Rroutes :R config/routes.rb
command! Rblueprints :R spec/blueprints.rb

nnoremap <Leader>aa :Tabularize /\|<CR>
vnoremap <Leader>aa :Tabularize /\|<CR>

" ### Search vimwiki
noremap <leader>ss :sb<cr>:call GetSearchInput()<cr>:VimwikiIndex<cr>:exe ":VimwikiSearch \/" . VWSearch . "\/"<cr>:lopen<cr>
function GetSearchInput()
  call inputsave()
  let g:VWSearch = input("Search Vimwiki:")
  call inputrestore()
endfunction


" #### From DestroyAllSoftware screencast on file navigation in vim
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!bundle exec rspec " . a:filename
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
noremap <leader>r :call RunTestFile()<cr>
" Run only the example under the cursor
noremap <leader>R :call RunNearestTest()<cr>
" Run all test files
noremap <leader>rr :call RunTests('spec')<cr>

set t_Co=256
colorscheme ir_black
set background=dark

"colorscheme solarized
"set background=light
" toggle the background for solarized light or dark
"call togglebg#map("<F5>") 

if filereadable(glob("~/.vimrc.local"))
  source "~/.vimrc.local"
endif

