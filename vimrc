set nocompatible

let mapleader = ","

set t_Co=256
colorscheme railscasts

set grepprg=ack\ -H\ --nocolor\ --nogroup
set grepformat=%f:%l:%m

function! Ack(args)
  let grepprg_bak=&grepprg
  set grepprg=ack\ -H\ --nocolor\ --nogroup
  execute "silent! grep " . a:args
  botright copen
  let &grepprg=grepprg_bak
endfunction
command! -nargs=* -complete=file Ack call Ack(<q-args>)
" ,F to startup an ack search
map <leader>F :Ack<space>

" Fuzzy Finder Textmate settings
let g:fuzzy_matching_limit=50
let g:fuzzy_ceiling = 5000
let g:fuzzy_ignore = "*.log;*.gif;*.png;git/**/*;.svn;.svn/**/*"

map <leader>f :FuzzyFinderTextMate<CR>
map <leader>t :FuzzyFinderTag<CR>
map <leader>b :FuzzyFinderBuffer<CR>
map <leader>] :FuzzyFinderMruFile<CR>
map <leader>w :BufO<CR>
map <leader>r :Rake<CR>

"   * if set g:gist_clip_command, gist.vim will copy the gist code.
let g:gist_clip_command = 'pbcopy'

" NERD snippets
"let g:NERDSnippets_key="<S-space>"
"let g:NERDSnippets_key="<C-tab>"
let g:NERDSnippets_key="<F7><F7>"

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

syntax on

set wildmenu
set autoread
set nobackup
set nowritebackup
set smartindent
set gdefault
set cursorline
set nu  " Line numbers on
set nowrap  " Line wrapping off
set directory=/tmp

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" don't use folder browser when adding to project listings
let g:proj_flags='imst'
" no menu, and no toolbar:
"set guioptions-=m
set guioptions-=T

set term=xterm-256color
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

" space = pagedown, - = pageup
noremap <Space> <PageDown>
noremap - <PageUp>

" remap'd keys
"map <Tab><Tab> <C-W>w
nnoremap <F5><F5> :set invhls hls?<CR>    " use f5f5 to toggle search hilight
nnoremap <F4><F4> :set invwrap wrap?<CR>  " use f4f4 to toggle wordwrap
nnoremap <F2><F2> :vsplit<CR>
nnoremap <F3><F3> <C-W>w
map <C-t> <Esc>:%s/[ ^I]*$//<CR>
nmap <leader>s :source ~/.vimrc
nmap <leader>v :e ~/.vimrc
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <F6><F6> :TlistToggle<CR>

"function RubyEndToken ()
"  let current_line = getline( '.' )
"  let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
"  let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
"  let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
"
"  if match(current_line, braces_at_end) >= 0
"    return "\<CR>}\<C-O>O"
"  elseif match(current_line, stuff_without_do) >= 0
"    return "\<CR>end\<C-O>O"
"  elseif match(current_line, with_do) >= 0
"    return "\<CR>end\<C-O>O"
"  else
"    return "\<CR>"
"  endif
"endfunction
"
"imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

" backup to ~/.tmp
"set backup
"set backupdir=$HOME/.tmp
"set writebackup

" misc
"set ai
set nohls
set incsearch
set showcmd
set nowrap

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" :alias
"com VR :vertical resize 80

