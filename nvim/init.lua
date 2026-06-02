-- ~/.config/nvim/init.lua
-- A lean Neovim config: colour + Treesitter + Telescope + (optional) LSP.
-- Tuned for READING code, not a full IDE. No completion, no autoformat-on-save.
--
-- Muscle-memory keymaps + settings merged from your old ~/.vimrc are tagged
-- with [.vimrc]. Plugin-bound bindings were translated to modern equivalents
-- (CtrlP->Telescope, Ack->Telescope, bufsurf->native, NERDTree->netrw).

--------------------------------------------------------------------------------
-- 1. Leader keys -- set BEFORE plugins load. [.vimrc] comma leader preserved.
--------------------------------------------------------------------------------
vim.g.mapleader = ','        -- [.vimrc] your leader. Note: this shadows the
                             -- default ',' (repeat-find-backwards) -- you lived
                             -- without it before. Remap it elsewhere if you miss it.
vim.g.maplocalleader = '\\'  -- [.vimrc] backslash localleader

--------------------------------------------------------------------------------
-- 2. Core options. Sensible reading defaults + your [.vimrc] preferences.
--------------------------------------------------------------------------------
local opt = vim.opt

opt.number = true             -- line numbers                         [.vimrc] set nu
opt.relativenumber = true     -- relative numbers (drop if you dislike)
opt.mouse = 'a'               -- mouse on                             [.vimrc] mouse=a
opt.termguicolors = true      -- 24-bit colour -- required for modern colourschemes
opt.signcolumn = 'yes'        -- always show sign column so text doesn't jump
opt.cursorline = true         -- highlight current line               [.vimrc] cursorline
opt.scrolloff = 8             -- context lines above/below cursor     [.vimrc] had 3
opt.wrap = false              -- no soft-wrap                         [.vimrc] nowrap
opt.sidescroll = 1            -- smooth horizontal scroll w/ nowrap   [.vimrc]
opt.sidescrolloff = 10        --                                      [.vimrc]
opt.title = true              -- set terminal title                   [.vimrc] title
opt.winwidth = 84             -- keep active window readable          [.vimrc] (DAS screencast)

opt.ignorecase = true         -- case-insensitive search...
opt.smartcase = true          -- ...unless you type a capital
opt.hlsearch = true           -- highlight matches                    [.vimrc] hls
opt.incsearch = true          -- show matches as you type             [.vimrc] incsearch
opt.gdefault = true           -- :s substitutes all-on-line by default [.vimrc] gdefault
opt.virtualedit = 'block'     -- let visual-block go past EOL         [.vimrc]

opt.splitright = true         -- vertical splits open right
opt.splitbelow = true         -- horizontal splits open below

opt.undofile = true           -- persistent undo
opt.swapfile = false          -- no swap files
opt.backup = false            --                                      [.vimrc] nobackup
opt.writebackup = false       --                                      [.vimrc] nowritebackup
opt.updatetime = 250          -- snappier CursorHold / gitsigns
opt.clipboard = 'unnamedplus' -- system clipboard (comment out for vim's own)
opt.shortmess:append('I')     -- skip the intro screen                [.vimrc] shortmess+=I

-- Spaces, 2-wide.                                                     [.vimrc]
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Whitespace markers, OFF by default, toggle with <leader>w.         [.vimrc] lcs + list!
opt.list = false
opt.listchars = { tab = '  ', eol = '$', trail = '~', extends = '>', precedes = '<' }

-- Folding: indent-based, open by default.                            [.vimrc] fold settings
opt.foldmethod = 'indent'
opt.foldnestmax = 10
opt.foldenable = false
opt.foldlevel = 99

-- Save all when the terminal loses focus.                            [.vimrc] au FocusLost :wa
vim.api.nvim_create_autocmd('FocusLost', { command = 'silent! wall' })

--------------------------------------------------------------------------------
-- 3. Muscle-memory keymaps from your [.vimrc]. Motions otherwise vanilla.
--------------------------------------------------------------------------------
local map = vim.keymap.set

-- Modern niceties (not from vimrc)
map('n', '<Esc>', '<cmd>nohlsearch<CR>')            -- clear search highlight
map('n', '<C-h>', '<C-w>h')                         -- [.vimrc] window nav
map('n', '<C-j>', '<C-w>j')                         -- [.vimrc]
map('n', '<C-k>', '<C-w>k')                         -- [.vimrc]
map('n', '<C-l>', '<C-w>l')                         -- [.vimrc]

map('n', '<leader><leader>', '<C-^>', { desc = 'Alternate buffer' })       -- [.vimrc]
map({ 'n', 'v' }, 'j', 'gj')                        -- [.vimrc] move by display line
map({ 'n', 'v' }, 'k', 'gk')                        -- [.vimrc]
map('n', '..', "'.zz", { desc = 'Jump to last change + centre' })          -- [.vimrc]
map({ 'n', 'v' }, '<Space>', '<PageDown>')          -- [.vimrc] space = page down
map({ 'n', 'v' }, '-', '<PageUp>')                  -- [.vimrc] minus = page up
map('i', 'jk', '<Esc>')                             -- [.vimrc] faster Esc
map({ 'n', 'v' }, 'Q', 'gq')                        -- [.vimrc] Q = format
map('n', 'H', '<cmd>bprevious<CR>', { desc = 'Prev buffer' })  -- [.vimrc] was BufSurfBack
map('n', 'L', '<cmd>bnext<CR>',     { desc = 'Next buffer' })  -- [.vimrc] was BufSurfForward
map('n', '<leader>w', '<cmd>set list!<CR>', { desc = 'Toggle whitespace' }) -- [.vimrc]
map('n', '<leader>ev', '<cmd>edit $MYVIMRC<CR>', { desc = 'Edit init.lua' }) -- [.vimrc] was <leader>ev
map('n', '<leader>d', '<cmd>Explore<CR>', { desc = 'File explorer (netrw)' }) -- [.vimrc] was NERDTree

-- Enter = open a blank line below (kept off in quickfix/help).       [.vimrc] <CR> o<Esc>
map('n', '<CR>', 'o<Esc>', { desc = 'Blank line below' })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'help', 'man' },
  callback = function() map('n', '<CR>', '<CR>', { buffer = true }) end,
})

-- Command-line conveniences
map('c', '%%', "<C-R>=expand('%:h').'/'<CR>", {})          -- [.vimrc] %% -> current dir
map('c', 'w!!', 'w !sudo tee % >/dev/null', {})            -- [.vimrc] sudo write

--------------------------------------------------------------------------------
-- 4. Bootstrap lazy.nvim -- the PLUGIN MANAGER, not the LazyVim distro.
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- 5. Plugins. Five entries. Read top to bottom -- nothing hidden.
--------------------------------------------------------------------------------
require('lazy').setup({

  -- (a) Colourscheme. tokyonight-night is the modern ir_black, basically.
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('tokyonight-night')
      -- darker/closer to ir_black: try 'rebelot/kanagawa.nvim' or gruvbox.
    end,
  },

  -- (b) Treesitter -- accurate tree-based highlighting. Your "I want colour" win.
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'vim', 'vimdoc', 'bash', 'markdown',
          'ruby', 'python', 'javascript', 'typescript', 'tsx',
          'scala', 'json', 'yaml', 'toml', 'html', 'css', 'go', 'rust', 'elixir', 'heex', 'eex', 
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- (c) Telescope -- replaces both CtrlP (files) and Ack (grep) from your vimrc.
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local t = require('telescope.builtin')
      map('n', '<C-p>',      t.find_files,  { desc = 'Find files' })       -- [.vimrc] CtrlP
      map('n', '<leader>f',  t.live_grep,   { desc = 'Grep repo' })        -- [.vimrc] Ack
      map('n', '<leader>F',  t.grep_string, { desc = 'Grep word under cursor' }) -- [.vimrc] SearchWord
      map('n', '<leader>sb', t.buffers,     { desc = 'Buffers' })
      map('n', '<leader>sh', t.help_tags,   { desc = 'Help tags' })
    end,
  },

  -- (d) Git signs in the gutter. Light, optional.
  { 'lewis6991/gitsigns.nvim', opts = {} },

  ------------------------------------------------------------------------------
  -- (e) OPTIONAL: LSP -- go-to-definition, references, hover. Turns "reading
  --     text" into "navigating code". No completion engine (the IDE weight).
  --     Delete this whole block for pure read-only highlighting.
  ------------------------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local m = function(keys, fn, desc)
            map('n', keys, fn, { buffer = event.buf, desc = desc })
          end
          m('gd', vim.lsp.buf.definition,      'Goto Definition')
          m('gr', vim.lsp.buf.references,      'Goto References')
          m('gD', vim.lsp.buf.declaration,     'Goto Declaration')
          m('K',  vim.lsp.buf.hover,           'Hover Docs')
          m('<leader>rn', vim.lsp.buf.rename,  'Rename Symbol')
          m('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        end,
      })
      -- Install servers with :Mason, then enable them here, one line each:
      vim.lsp.enable({
        'elixirls', 'lua_ls', 'ruby_ls', 'ts_ls',
      })
    end,
  },

}, {
  ui = { border = 'rounded' },
})

--------------------------------------------------------------------------------
-- Deliberately NOT ported (plugin/workflow specific). How to get them back:
--   * Fugitive git maps (<leader>gs/gd/gb...) -> add 'tpope/vim-fugitive'
--   * vim-surround                            -> add 'kylechui/nvim-surround'
--   * NERDCommenter                           -> built-in: gcc / gc (Neovim 0.10+)
--   * Tabularize <leader>aa                   -> add 'godlygeek/tabular' (still works)
--   * RSpec runners / Vimwiki / Yankring / UltiSnips / YouCompleteMe -- left out
--     by design; this is a reading setup, not your old Rails IDE.
--
-- Cheatsheet (leader = ,):
--   <C-p> files   ,f grep   ,F grep-word   ,sb buffers   ,sh help
--   ,, alt-buffer   H/L prev/next buffer   ,d explorer   ,w whitespace toggle
--   ,ev edit config   jk = Esc   j/k = display lines   Q = format
--   gd/gr/K definition/refs/hover (LSP)
--------------------------------------------------------------------------------
