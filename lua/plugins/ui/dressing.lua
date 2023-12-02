return {
  'stevearc/dressing.nvim',
  opts = {
    input = {
      default_prompt = '',
      -- Can be 'left', 'right', or 'center'
      title_pos = "left",

      -- These are passed to nvim_open_win
      override = function(conf)
        conf.anchor = 'SW'
        return conf
      end,
      border = 'rounded',
      -- 'editor' and 'win' will default to being centered
      relative = 'cursor',

      max_width = { 90, 0.8 },
      min_width = { 20, 0.2 },

      win_options = {
        -- Window transparency (0-100)
        winblend = 0,
        -- Disable line wrapping
        wrap = false,
        -- Indicator for when text exceeds window
        list = true,
        listchars = "precedes:…,extends:…",
        -- Increase this for more context when text scrolls off the window
        sidescrolloff = 0,
      },
    },
    select = {}
  },
  config = function(_, opts)
    require 'dressing'.setup(opts)
  end
}
