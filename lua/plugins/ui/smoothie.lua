return {
  Spec {
    'psliwka/vim-smoothie',
    config = function()
      vim.g.smoothie_enabled = true
      vim.g.smoothie_no_default_mappings = true
    end,
  },
}
