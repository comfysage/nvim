-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀

vim.o.guifont = "Maple Mono NF:h11"
vim.opt.linespace = 0
vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_left = 1
vim.g.neovide_padding_right = 1
vim.g.neovide_hide_mouse_when_typing = true

-- █▄▄ ▄▀█ █▀▀ █▄▀ █▀▀ █▀█ █▀█ █░█ █▄░█ █▀▄
-- █▄█ █▀█ █▄▄ █░█ █▄█ █▀▄ █▄█ █▄█ █░▀█ █▄▀

vim.g.neovide_theme = 'dark'
vim.g.neovide_transparency = 0.9
vim.g.transparency = 1
vim.g.neovide_background_color = '#1d2021'

---@diagnostic disable-next-line: undefined-global, undefined-field, inject-field
core.config.transparent_background = false

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function ()
    vim.cmd[[ redraw! ]]
  end
})

-- ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
-- █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

vim.g.neovide_cursor_trail_size = 0.6
