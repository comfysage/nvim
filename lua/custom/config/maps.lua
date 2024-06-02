keymaps.normal['<space>R'] = {
  function()
    require('core').reload()
  end,
  'reload config',
}

keymaps.normal['<leader>s'] = {
  function()
    vim.cmd.source '%'
    vim.notify('sourcing current file.', vim.log.levels.INFO)
  end,
  'Source File',
}
keymaps.visual['<leader>s'] = { "<Cmd>'<,'>source<CR>", 'Source File Segment' }

Keymap.group {
  group = 'file',
  { 'normal', '<c-s>', vim.cmd.update, 'save file' },
  { 'insert', '<c-s>', vim.cmd.update, 'save file' },
}

keymaps.normal[',s'] = {
  function()
    ---@type table<integer, {name: string}>
    local clients = vim.lsp.get_clients { bufnr = 0 }
    local null = {}
    local lsp = {}
    for _, client in ipairs(clients) do
      if client.name == 'null-ls' then
        null[#null + 1] = client.name
      else
        lsp[#lsp + 1] = client.name
      end
    end

    local client = nil
    if #null > 0 then
      client = null[1]
    else
      client = lsp[1]
    end
    if client then
      vim.notify(
        ('formatting current file with "%s"'):format(client),
        vim.log.levels.INFO
      )
      vim.lsp.buf.format { async = true, name = client }
    end
  end,
  'format file',
  group = 'file',
}

keymaps.normal[';'] = { function()
  vim.notify('use `v;`', vim.log.levels.WARN)
end, '' }
vim.keymap.set('o', ';', 'iw', { desc = 'select inside word' })
vim.keymap.set('v', ';', 'iw', { desc = 'select inside word' })
-- nnoremap <C-d> <ESC>viw
-- inoremap <C-d> <ESC>viw

Keymap.group {
  group = 'movement',
  { 'normal', 'W', 'g_', 'goto last non empty of line' },
  { 'normal', 'B', '^',  'goto first non empty of line' },
  { 'visual', 'W', 'g_', 'goto last non empty of line' },
  { 'visual', 'B', '^',  'goto first non empty of line' },
}
--nmap <space><space> <ESC>:<BACKSPACE>zz

-- vmap <leader>c "*y
-- nmap <leader>v "*p

keymaps.normal['<S-up>'] = { '<nop>', 'disable shift movement' }
keymaps.normal['<S-down>'] = { '<nop>', 'disable shift movement' }

-- Move Selected Line up and down
-- nnoremap J <Cmd>move +1<CR>
-- nnoremap K <Cmd>move -2<CR>
keymaps.visual['J'] = { ":move '>+1<CR>gv-gv", 'Move line down' }
keymaps.visual['K'] = { ":move '<-2<CR>gv-gv", 'Move line up' }

Keymap.group {
  group = 'editing',
  { 'visual', 'J', ":move '>+1<CR>gv-gv", 'Move line down' },
  { 'visual', 'K', ":move '<-2<CR>gv-gv", 'Move line up' },
}

Keymap.group {
  group = 'file',
  { 'normal', ',ff', 'gg=G``:w<CR>',        'Fix indention in file' },
  { 'normal', ',m', '<Cmd>%norm! gww<CR>', 'Fix line length in file' },
}

-- keymaps.normal['<M-F>'] = { '<cmd>!prettygo %<CR>', 'Format Current Document' }

-- Surround Selection
keymaps.visual['o'] = { "<ESC>'<O<ESC>'>o<ESC>gv", 'Surround Selection' }

keymaps.normal['D'] = { '0d$', 'clear current line' }

-- Move through wrapping lines {{{

-- j/k will move virtual (wrapping) lines.
vim.cmd [[ noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j') ]]
vim.cmd [[ noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k') ]]

-- }}}

-- toggle statusline
keymaps.normal['<space><ESC>'] =
{ '<Cmd>ToggleStatusLine<CR>', 'Toggle statusline' }

require 'custom.better-s'

keymaps.normal['s/'] =
{ '<Cmd>SubstituteSelection<CR>', 'Substitute Last Selection' }

-- create splits
Keymap.group {
  group = 'windows',
  { 'normal', 'sv', ':vsp<cr>', 'split window vertically' },
  { 'normal', 'sh', ':sp<cr>',  'split window horizontally' },
}
keymaps.normal['sq'] = { '<C-w>q', 'Quit Current Window' }

keymaps.normal[{ 'SPC', 'e' }] =
{ '<Cmd>bo 20sp +term<CR>', 'Open Terminal Pane' }

Keymap.group {
  group = 'windows',
  { 'normal',  '<space><Left>',   ':wincmd h<CR>', '' },
  { 'normal',  '<space><Down>',   ':wincmd j<CR>', '' },
  { 'normal',  '<space><Up>',     ':wincmd k<CR>', '' },
  { 'normal',  '<space><Right>',  ':wincmd l<CR>', '' },

  { 'normal',  '<space>h',        ':wincmd h<CR>', '' },
  { 'normal',  '<space>j',        ':wincmd j<CR>', '' },
  { 'normal',  '<space>k',        ':wincmd k<CR>', '' },
  { 'normal',  '<space>l',        ':wincmd l<CR>', '' },
}

-- smoothie
if vim.g.smoothie_enabled then
  keymaps.normal['<S-down>'] = {
    '<cmd>call smoothie#do("\\<C-D>") <CR>',
    'Scroll Down',
    { overwrite = true },
  }
  keymaps.normal['<S-up>'] = {
    '<cmd>call smoothie#do("\\<C-U>") <CR>',
    'Scroll Up',
    { overwrite = true },
  }
  keymaps.normal['zz'] = {
    '<cmd>call smoothie#do("zz") <CR>',
    'Center window',
    { overwrite = true },
  }
  keymaps.normal['zt'] = {
    '<cmd>call smoothie#do("zt") <CR>',
    'Align cursor to top',
    { overwrite = true },
  }
  keymaps.normal['zb'] = {
    '<cmd>call smoothie#do("zb") <CR>',
    'Align cursor to bottom',
    { overwrite = true },
  }
  keymaps.normal['gg'] = {
    '<cmd>call smoothie#do("gg") <CR>',
    'Scroll to top of file',
    { overwrite = true },
  }
  keymaps.normal['G'] = {
    '<cmd>call smoothie#do("G") <CR>',
    'Scroll to bottom of file',
    { overwrite = true },
  }
end

if vim.g.smoothie_enabled then
  keymaps.normal['ss'] =
  { '<cmd>call smoothie#do("zz") <CR>', 'Center window', { remap = false } }
  keymaps.normal['sa'] = {
    '<cmd>call smoothie#do("zt") <CR>',
    'Align cursor to top',
    { remap = false },
  }
  keymaps.normal['sd'] = {
    '<cmd>call smoothie#do("zb") <CR>',
    'Align cursor to bottom',
    { remap = false },
  }
else
  keymaps.normal['ss'] = { 'zz', 'Center window', { remap = false } }
  keymaps.normal['sa'] = { 'zt', 'Align cursor to top', { remap = false } }
  keymaps.normal['sd'] = { 'zb', 'Align cursor to bottom', { remap = false } }
end

keymaps.normal['gcu'] = { 'yyp^wv$hr-', 'Underline Comment' }

-- netrw
-- keymaps.normal["<space>n"] = { "<cmd>20Lex!<CR>", 'Open Tree' }
keymaps.normal['<space>n'] = { '<cmd>to 40vs .<cr>', 'Open Tree' }

local _, ok = pcall(require, 'telescope')
if ok then
  keymaps.normal['<space>T'] =
  { function()
    require 'telescope.builtin'.builtin()
  end, group = 'Telescope', 'Telescope' }
end
