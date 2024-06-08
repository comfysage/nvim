return {
  'mickael-menu/zk-nvim',
  ft = 'markdown',
  opts = {
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = 'telescope',

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { 'zk', 'lsp' },
        name = 'zk_lsp',
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start_client()`
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { 'markdown' },
      },
    },
  },
  config = function(_, opts)
    require('zk').setup(opts)
  end,
}
