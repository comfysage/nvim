return {
  {
    'nvim-tree/nvim-tree.lua',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "right",
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    },
    config = function(_, opts)
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require 'nvim-tree'.setup (opts)
    end
  }
}
