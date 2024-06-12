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
  group = 'windows',
  { 'normal', '<leader>w=', function() vim.cmd [[ vert resize +5 ]] end, 'horizontally increase window size'},
  { 'normal', '<leader>w-', function() vim.cmd [[ vert resize -5 ]] end, 'horizontally decrease window size'},
  { 'normal', '<leader>w+', function() vim.cmd [[ resize +5 ]] end, 'vertically increase window size'},
  { 'normal', '<leader>w_', function() vim.cmd [[ resize -5 ]] end, 'vertically decrease window size'},
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

-- Move Selected Line up and down
-- nnoremap J <Cmd>move +1<CR>
-- nnoremap K <Cmd>move -2<CR>

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

-- Surround Selection
keymaps.visual['o'] = { "<ESC>'<O<ESC>'>o<ESC>gv", 'Surround Selection' }

keymaps.normal['D'] = { '0d$', 'clear current line' }

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
