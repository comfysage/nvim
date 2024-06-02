return {
  'crispybaccoon/shelf.nvim', dev = true,
  event = 'BufEnter',
  opts = {},
  config = function(_, opts)
    require('shelf').setup(opts)

    keymaps.normal['<leader>p'] = {
      function()
        require('shelf.ui').open()
      end,
      'show buffers',
    }
  end,
}
