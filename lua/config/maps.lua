keymaps.normal['<space>sll'] = {
  function()
    require('lazy').home()
  end,
  'Open Lazy',
}

keymaps.normal['<space>R'] = { function()
  require 'core'.reload()
end, 'reload config' }

keymaps.normal['<leader>s'] = { function()
  vim.cmd.source '%'
  vim.notify('sourcing current file.', vim.log.levels.INFO)
end, 'Source File' }
keymaps.visual['<leader>s'] = { "<Cmd>'<,'>source<CR>", 'Source File Segment' }

-- Basic Keybinds {{{
Keymap.group {
  group = 'file',
  { 'normal', '<c-s>', vim.cmd.update, 'save file' },
  { 'insert', '<c-s>', vim.cmd.update, 'save file' },
}

keymaps.normal[';'] = { 'viw', '' }
-- nnoremap <C-d> <ESC>viw
-- inoremap <C-d> <ESC>viw

Keymap.group {
  group = 'movement',
  { 'normal', 'W', 'g_', 'goto last non empty of line' },
  { 'normal', 'B', '^', 'goto first non empty of line' },
  { 'visual', 'W', 'g_', 'goto last non empty of line' },
  { 'visual', 'B', '^', 'goto first non empty of line' },
}
--nmap <space><space> <ESC>:<BACKSPACE>zz

keymaps.normal[{ 'SPC', 's', 'q' }] =
  { ':copen<cr>', 'open qf list', group = 'qf_list' }


-- Invert NumberLine
keymaps.normal['<leader>n'] = { ':set invnu<CR>', '' }

-- vmap <leader>c "*y
-- nmap <leader>v "*p

-- Move Selected Line up and down
-- nnoremap J <Cmd>move +1<CR>
-- nnoremap K <Cmd>move -2<CR>
Keymap.group {
  group = 'editing',
  { 'visual', 'J', ":move '>+1<CR>gv-gv", 'Move line down' },
  { 'visual', 'K', ":move '<-2<CR>gv-gv", 'Move line up' },
}

keymaps.normal[',f'] = { 'gg=G``:w<CR>', 'Fix indention in file' }
keymaps.normal[',m'] = { '<Cmd>%norm! gww<CR>', 'Fix line length in file' }

-- keymaps.normal['<M-F>'] = { '<cmd>!prettygo %<CR>', 'Format Current Document' }

-- Surround Selection
keymaps.visual["o"] = { "<ESC>'<O<ESC>'>o<ESC>gv", 'Surround Selection' }

keymaps.normal['C'] = { 'cc<ESC>', 'Clear current line' }
keymaps.normal['<M-v>'] = { '^vg_', 'Select contents of current line' }

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

-- nmap <silent> <space>w :vs<CR>:wincmd l<CR>:RangerWorkingDirectory<CR>


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
end
