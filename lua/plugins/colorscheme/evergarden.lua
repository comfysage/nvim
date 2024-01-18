return Spec.colorscheme {
  'crispybaccoon/evergarden',
  opts = {
    override_terminal = true,
    transparent_background = false,
    contrast_dark = 'medium',
    style = {
        tabline = { reverse = false, color = "red" },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = false },
    },
    overrides = {},
  }
}
