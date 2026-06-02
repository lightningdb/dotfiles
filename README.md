# dotfiles

My dotfiles. Rebuilt from scratch in June 2026 — the previous decade-plus of
Vim/Vundle, Taskwarrior, Vimwiki, ack and Ruby-era config was archived rather
than carried forward (see [Legacy](#legacy) below).

## What's here

| File | What it is |
|------|------------|
| `nvim/init.lua` | Neovim config — lean, reading-focused: Treesitter, Telescope, LSP. No IDE bloat. |
| `git_aliases` | Shell aliases for git (`s`, `d`, `gco`, `glog`, per-hunk `gap`/`grp`/`gcop`, …). |
| `tmux.conf` | tmux 3.x config — `C-z` prefix, vi mode, no-prefix pane/window nav. |
| `make_symlinks.sh` | Symlinks the above into place (backs up anything existing to `*.bak`). |

## Install

```sh
./make_symlinks.sh
```

Then wire up the bits that need sourcing/reloading:

```sh
echo 'source ~/.git_aliases' >> ~/.zshrc   # load the git aliases
tmux source ~/.tmux.conf                   # or C-z r inside tmux
```

First `nvim` launch bootstraps lazy.nvim and installs plugins automatically.
Run `:checkhealth` if anything looks off. For language intelligence: `:Mason`,
install the server, add it to the `vim.lsp.enable({…})` list in `init.lua`.

### Requirements

- Neovim ≥ 0.9 (Treesitter/LSP)
- `ripgrep` (Telescope grep), `fd` (faster file finding) — optional but nice
- A C compiler (Treesitter compiles parsers locally)

## Legacy

Everything before the 2026 rebuild — vimrc, Vimwiki, Taskwarrior, the old vim
colours/syntax, Ruby configs — lives in the **`archive/pre-2026`** tag:

```sh
git checkout archive/pre-2026
```

It's preserved, not deleted. `master` only carries what I actually run now.
