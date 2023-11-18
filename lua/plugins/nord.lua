return {
  Spec.colorscheme {
    'AlexvZyl/nordic.nvim',
  },
  Spec.colorscheme {
    'shaunsingh/nord.nvim',
    enabled = false,
    config = function()
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_cursorline_transparent = false
      vim.g.nord_enable_sidebar_background = false
      vim.g.nord_bold = false
      vim.g.nord_italic = false
    end
  }
}
