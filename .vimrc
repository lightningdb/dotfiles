let mapleader = ","

set t_Co=256
colorscheme railscasts

set nocompatible

" add recently accessed projects menu (project plugin)
set viminfo^=!

set grepprg=ack\ -H\ --nocolor\ --nogroup
set grepformat=%f:%l:%m

:nnoremap <leader>d :NERDTreeToggle<CR>

" Fuzzy Finder Textmate settings
let g:fuzzy_ceiling = 50000
let g:fuzzy_ignore = "git/**/*;.svn;.svn/**/*"

map <leader>t :FuzzyFinderTextMate<CR>
map <leader>b :FuzzyFinderBuffer<CR>
map <leader>] :FuzzyFinderMruFile<CR>

" NERD snippets
"let g:NERDSnippets_key = "<c-[>"
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
map <leader>n :NERDTree<CR>


function RubyEndToken ()
  let current_line = getline( '.' )
  let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
  let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
  let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

  if match(current_line, braces_at_end) >= 0
    return "\<CR>}\<C-O>O" 
  elseif match(current_line, stuff_without_do) >= 0
    return "\<CR>end\<C-O>O" 
  elseif match(current_line, with_do) >= 0
    return "\<CR>end\<C-O>O" 
  else
    return "\<CR>" 
  endif
endfunction

imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

" backup to ~/.tmp
"set backup
"set backupdir=$HOME/.tmp
"set writebackup
 
" misc
"set ai
"set nohls
set hls
set incsearch
set showcmd
set nowrap

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" :alias
com VR :vertical resize 80

function! Find(name)
  let l:_name = substitute(a:name, "\\s", "*", "g")
  let l:list=system("find . -iname '*".l:_name."*' -not -name \"*.class\" -and -not -name \"*.swp\" | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (<enter>=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

map ,f :Fi

