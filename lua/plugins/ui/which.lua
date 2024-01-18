return {
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {
      key_labels = {
        ["<space>"] = "SPC",
        ["<cr>"] = "CR",
        ["<tab>"] = "TAB",
        ["<s-tab>"] = "SHIFT TAB",
      },
    },
    config = function(_, opts)
      local status, which = pcall(require, 'which-key')
      if not status then return end

      which.setup(opts)

      which.register({
        ['.'] = { name = 'toggle' },
        [','] = { name = 'edit' },
        ['<leader>'] = {
          f = { name = 'find' },
          s = { name = 'show' },
          g = { name = 'go' },
        },
      })
    end
  }
}
