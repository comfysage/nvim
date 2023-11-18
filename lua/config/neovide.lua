vim.o.guifont = "JetBrainsMono NF:h9"
vim.opt.linespace = 1
vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_left = 1
vim.g.neovide_padding_right = 1

vim.g.neovide_transparency = 1.0
vim.g.transparency = 1

toggle_transparent_background(false)

keymaps.normal['<C-V>'] = { '"+p', 'paste from system clipboard' }
keymaps.visual['<C-C>'] = { '"+y', 'copy to system clipboard' }
