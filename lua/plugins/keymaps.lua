return {
  'crispybaccoon/keymaps.nvim',
  dir = ENV('KITCHEN') .. '/pan/keymaps.nvim',
  priority = 2000,
  opts = {
  },
  config = function(_, opts)
    local status, keymaps_nvim = pcall(require, 'keymaps')
    if not status then return end
    keymaps_nvim.setup {}

    local status, telescope = pcall(require, 'telescope')
    if status then
      telescope.load_extension 'keymaps_nvim'
      keymaps.normal['<space>fm'] = { require 'telescope'.extensions.keymaps_nvim.keymaps_nvim, group = 'Telescope',
        'Find Keymaps' }
    end
  end
}
