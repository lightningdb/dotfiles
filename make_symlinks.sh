#!/bin/zsh
files="
ackrc
gvimrc
rdebugrc
riplrc
taskrc
tmux.conf
vimrc
"

for file in $files
do
  rm "~/.${file}" && ln -s ~/dotfiles/${file} ~/.${file}
done

# Left the edgecases alone
rm ~/.task && ln -s ~/Dropbox/.task ~/.task
ln -s ~/Dropbox/vimwiki ~/vimwiki
