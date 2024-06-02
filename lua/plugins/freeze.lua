return {
  'charm-community/freeze.nvim',
  lazy = true,
  cmd = { 'Freeze' },
  opts = {
    padding = { 20, 40, 20, 20 },
    font = {
      size = 13,
      family = 'JetBrainsMono NF',
      ligatures = true,
    },
    border = {
      radius = 8,
      width = 1,
      color = '#515151',
    },
    command = 'freeze',
    output = function()
      return vim.fn.getcwd() .. '/' .. os.date '%Y-%m-%d-%N' .. '_freeze.png'
    end,
    theme = 'gruvbox',
  },
}
