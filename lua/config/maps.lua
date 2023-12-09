local keymaps = require 'keymaps'.setup()

keymaps.normal['<space>sl'] = { function() require 'lazy'.home() end, 'Open Lazy' }

keymaps.normal['<space>R'] = { function()
  require 'core'.reload()
end, 'reload config' }

keymaps.normal['<leader>s'] = { function()
  vim.cmd.source '%'
  vim.notify('sourcing current file.', vim.log.levels.INFO)
end, 'Source File' }
keymaps.visual['<leader>s'] = { "<Cmd>'<,'>source<CR>", 'Source File Segment' }
keymaps.normal['<C-s>'] = { vim.cmd.update, 'Save File' }
keymaps.insert['<C-s>'] = { vim.cmd.update, 'Save File' }

-- Ranger
keymaps.normal['<leader>f'] = { '<cmd>Ranger<CR>', 'Open Ranger' }
keymaps.normal['<leader>g'] = { '<cmd>RangerNewTab<CR>', 'Open Ranger in a New Tab' }
keymaps.normal['<space>r'] = { '<cmd>RangerTree<CR>', 'Open RangerTree' }

-- Basic Keybinds {{{

keymaps.normal[';'] = { 'viw', '' }
-- nnoremap <C-d> <ESC>viw
-- inoremap <C-d> <ESC>viw

keymaps.normal['W'] = { 'g_', 'Goto last non empty of line' }
keymaps.normal['B'] = { '^', 'Goto first non empty of line' }
keymaps.visual['W'] = { 'g_', 'Goto last non empty of line' }
keymaps.visual['B'] = { '^', 'Goto first non empty of line' }
--nmap <space><space> <ESC>:<BACKSPACE>zz

-- quick fix list
keymaps.normal['<c-n>'] = { ':cnext<cr>', 'goto next item in qf list' }
keymaps.normal['<c-b>'] = { ':cprev<cr>', 'goto prev item in qf list' }

keymaps.normal[{ 'SPC', 's', 'q' }] = { ':copen<cr>', 'open qf list' }

-- Invert NumberLine
keymaps.normal['<leader>n'] = { ':set invnu<CR>', '' }

-- vmap <leader>c "*y
-- nmap <leader>v "*p

-- Move Selected Line up and down
-- nnoremap J <Cmd>move +1<CR>
-- nnoremap K <Cmd>move -2<CR>
keymaps.visual['J'] = { ":move '>+1<CR>gv-gv", 'Move line down' }
keymaps.visual['K'] = { ":move '<-2<CR>gv-gv", 'Move line up' }

-- < and > indents
keymaps.visual['<'] = { "<gv", 'Decrease indention' }
keymaps.visual['>'] = { ">gv", 'Increase indention' }

keymaps.normal[',f'] = { 'gg=G``:w<CR>', 'Fix indention in file' }
keymaps.normal[',m'] = { '<Cmd>%norm! gww<CR>', 'Fix line length in file' }

-- keymaps.normal['<M-F>'] = { '<cmd>!prettygo %<CR>', 'Format Current Document' }

-- Surround Selection
keymaps.visual["o"] = { "<ESC>'<O<ESC>'>o<ESC>gv", 'Surround Selection' }

keymaps.normal["++"] = { "gcc", 'Comment Line' }
keymaps.visual["++"] = { "gc", 'Comment Selection' }

keymaps.normal['C'] = { 'cc<ESC>', '' }
keymaps.normal['<M-v>'] = { '^v$', '' }

keymaps.normal['B'] = { ':Bclose ', '' }

-- }}}

-- Move through wrapping lines {{{

-- j/k will move virtual (wrapping) lines.
vim.cmd [[ noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j') ]]
vim.cmd [[ noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k') ]]

-- }}}

-- toggle statusline
keymaps.normal["<space><ESC>"] = { "<Cmd>ToggleStatusLine<CR>", 'Toggle statusline' }

require 'config.better-s'

keymaps.normal["s/"] = { "<Cmd>SubstituteSelection<CR>", 'Substitute Last Selection' }

-- create splits
keymaps.normal["sv"] = { "<C-w>v", 'Split Window Vertically' }
keymaps.normal["sh"] = { "<Cmd>sp<CR>", 'Split Window Horizontally' }
keymaps.normal["sq"] = { "<C-w>q", 'Quit Current Window' }

-- Split File {{{

keymaps.normal["<C-\\>"] = { ":vs<CR>:wincmd l<CR>", 'Split File Vertically' }
-- nmap <silent> <space>w :vs<CR>:wincmd l<CR>:RangerWorkingDirectory<CR>

-- }}}

-- Split Navigation {{{

keymaps.normal['<space><Left>'] = { ':wincmd h<CR>', '' }
keymaps.normal['<space><Down>'] = { ':wincmd j<CR>', '' }
keymaps.normal['<space><Up>'] = { ':wincmd k<CR>', '' }
keymaps.normal['<space><Right>'] = { ':wincmd l<CR>', '' }

keymaps.normal['<space>h'] = { ':wincmd h<CR>', '' }
keymaps.normal['<space>j'] = { ':wincmd j<CR>', '' }
keymaps.normal['<space>k'] = { ':wincmd k<CR>', '' }
keymaps.normal['<space>l'] = { ':wincmd l<CR>', '' }

-- }}}

-- tab navigation
keymaps.normal["<TAB>"] = { vim.cmd.tabnext, 'Next Tab' }
keymaps.normal["<S-TAB>"] = { vim.cmd.tabprev, 'Prev Tab' }

keymaps.normal["<space><TAB>"] = { ":$tabedit<CR>", 'Open New Tab' }

-- smoothie
vim.g.smoothie_enabled = true
vim.g.smoothie_no_default_mappings = true
if vim.g.smoothie_enabled then
  keymaps.normal["<C-J>"] = { '<cmd>call smoothie#do("\\<C-D>") <CR>', 'Scroll Down', { overwrite = true } }
  keymaps.normal["<C-K>"] = { '<cmd>call smoothie#do("\\<C-U>") <CR>', 'Scroll Up', { overwrite = true } }
  keymaps.normal["zz"] = { '<cmd>call smoothie#do("zz") <CR>', 'Center window', { overwrite = true } }
  keymaps.normal["zt"] = { '<cmd>call smoothie#do("zt") <CR>', 'Align cursor to top', { overwrite = true } }
  keymaps.normal["zb"] = { '<cmd>call smoothie#do("zb") <CR>', 'Align cursor to bottom', { overwrite = true } }
  keymaps.normal["gg"] = { '<cmd>call smoothie#do("gg") <CR>', 'Scroll to top of file', { overwrite = true } }
  keymaps.normal["G"] = { '<cmd>call smoothie#do("G") <CR>', 'Scroll to bottom of file', { overwrite = true } }
end

if vim.g.smoothie_enabled then
  keymaps.normal["ss"] = { '<cmd>call smoothie#do("zz") <CR>', 'Center window', { remap = false } }
  keymaps.normal["sa"] = { '<cmd>call smoothie#do("zt") <CR>', 'Align cursor to top', { remap = false } }
  keymaps.normal["sd"] = { '<cmd>call smoothie#do("zb") <CR>', 'Align cursor to bottom', { remap = false } }
else
  keymaps.normal["ss"] = { "zz", 'Center window', { remap = false } }
  keymaps.normal["sa"] = { "zt", 'Align cursor to top', { remap = false } }
  keymaps.normal["sd"] = { "zb", 'Align cursor to bottom', { remap = false } }
end

keymaps.normal["gcu"] = { "yyp^wv$hr-", 'Underline Comment' }

-- netrw
-- bind { "<space>n", "<cmd>20Lex!<CR>" }
keymaps.normal["<space>n"] = { "<cmd>to 20vs .<cr>", 'Open Tree' }

local _, status = pcall(require, 'telescope')
if status then
  keymaps.normal["<space>t"] = { "<cmd>Telescope<CR>", group = 'Telescope', "Telescope" }
  keymaps.normal["<space><space>"] = {
    function() require 'comfy.plugin.telescope'.space {} end,
    group = 'Telescope',
    "Find Files"
  }
  keymaps.normal["<space>fr"] = {
    function() require 'comfy.plugin.telescope'.grep {} end,
    group = 'Telescope',
    "[F]ind St[r]ing"
  }
  keymaps.normal["<space>fv"] = {
    function() require 'comfy.plugin.telescope'.edit_dotfiles() end,
    group = 'Telescope',
    "[F]ind [V]im file"
  }
  keymaps.normal["<space>ff"] = {
    function() require 'comfy.plugin.telescope'.explorer {} end,
    group = 'Telescope',
    "[F]ind [F]ile"
  }
  keymaps.normal["<space>/"] = {
    function() R 'comfy.plugin.telescope'.grep_current_file {} end,
    group = 'Telescope',
    "Find in file"
  }

  keymaps.normal["<space>fs"] = {
    function() require 'comfy.plugin.telescope'.symbols {} end,
    group = 'Telescope',
    "[F]ind [S]ymbols"
  }
  keymaps.normal["<space>fg"] = {
    function() require 'comfy.plugin.telescope'.git_files {} end,
    group = 'Telescope',
    "[F]ind [G]it file"
  }

  -- keymaps.normal["<space>fd"] = { function() require 'telescope'.extensions.file_browser.file_browser() end,
  --   group = 'Telescope', "Find with browser" }

  keymaps.normal["<space>fb"] = {
    function() require('telescope.builtin').buffers() end,
    group = 'Telescope',
    "[F]ind [B]uffer"
  }
  keymaps.normal["<space>ft"] = {
    function() require('telescope.builtin').filetypes() end,
    group = 'Telescope',
    "[F]ind File[T]ype"
  }
  keymaps.normal["<space>fk"] = {
    function() require('telescope.builtin').keymaps() end,
    group = 'Telescope',
    "[F]ind [K]eymap"
  }
  keymaps.normal["<space>fh"] = {
    function() require('telescope.builtin').help_tags() end,
    group = 'Telescope',
    "[F]ind [H]elp tag"
  }

  keymaps.normal["<C-t>"] = {
    function() require('telescope.builtin').colorscheme() end,
    group = 'Telescope',
    "Find Colorscheme"
  }
end
