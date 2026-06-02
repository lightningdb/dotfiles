#!/usr/bin/env zsh
# Symlink dotfiles into place. Backs up anything already there to *.bak.
set -e
DOTFILES="${0:A:h}"          # dir this script lives in

link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "${dst:h}"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "backup: $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "linked: $dst -> $src"
}

# Neovim config (XDG path)
link nvim/init.lua "$HOME/.config/nvim/init.lua"

# Git aliases — symlinked, then sourced from .zshrc (see note below)
link git_aliases "$HOME/.git_aliases"

link tmux.conf "$HOME/.tmux.conf"

echo "done."
