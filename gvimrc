colorscheme ir_black

if has("gui_gtk2")
  set guifont=DejaVu\ Sans\ Mono\ 9
elseif has("gui_macvim")
  set guifont=Menlo:h11
end

syntax on

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

let g:miniBufExplMaxSize = 3

