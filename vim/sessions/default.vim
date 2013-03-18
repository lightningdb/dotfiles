" ~/Dropbox/dotfiles/vim/sessions/default.vim: Vim session script.
" Created by session.vim 1.5 on 18 March 2013 at 14:25:00.
" Open this file in Vim and run :source % to restore your session.

set guioptions=egrL
silent! set guifont=Inconsolata-g:h16
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'solarized' | colorscheme solarized | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/Dropbox/vimwiki/index.wiki
badd +0 ~/Dropbox/vimwiki/GoalsJan2013.wiki
badd +0 ~/Dropbox/vimwiki/MyInbox.wiki
silent! argdel *
set lines=40 columns=140
edit ~/Dropbox/vimwiki/GoalsJan2013.wiki
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 19 + 20) / 40)
exe 'vert 1resize ' . ((&columns * 55 + 70) / 140)
exe '2resize ' . ((&lines * 18 + 20) / 40)
exe 'vert 2resize ' . ((&columns * 55 + 70) / 140)
exe 'vert 3resize ' . ((&columns * 84 + 70) / 140)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
enew
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=10
setlocal nofen
wincmd w
argglobal
edit ~/Dropbox/vimwiki/MyInbox.wiki
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 10 - ((9 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 0
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 19 + 20) / 40)
exe 'vert 1resize ' . ((&columns * 55 + 70) / 140)
exe '2resize ' . ((&lines * 18 + 20) / 40)
exe 'vert 2resize ' . ((&columns * 55 + 70) / 140)
exe 'vert 3resize ' . ((&columns * 84 + 70) / 140)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=84 shortmess=filnxtToOI
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
tabnext 1
3wincmd w

" vim: ft=vim ro nowrap smc=128
