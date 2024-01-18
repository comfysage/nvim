vim.o.guifont = "Maple Mono:h11"
vim.opt.linespace = 1
vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_left = 1
vim.g.neovide_padding_right = 1

vim.g.neovide_transparency = 0.9
vim.g.transparency = 1

toggle_transparent_background(false)

keymaps.normal['<C-V>'] = { '"+p', 'paste from system clipboard' }
keymaps.visual['<C-C>'] = { '"+y', 'copy to system clipboard' }

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function ()
    vim.cmd[[ redraw! ]]
  end
})
