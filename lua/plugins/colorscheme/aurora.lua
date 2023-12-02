return Spec.colorscheme {
  'crispybaccoon/aurora',
  dir = ENV('KITCHEN') .. '/pan/aurora',
  opts = {
    transparent_background = false,
    contrast_dark = 'medium',
    style = {},
    overrides = {},
  }
}
