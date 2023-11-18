-- config.init
return require 'comfy'.setup {
  colorscheme = 'evergarden',
  transparent_background = true,
  transparent_fn = {
    evergarden = function(t)
      _G.evergarden_config.transparent_background = t
    end,
    aurora = function(t)
      _G.aurora_config.transparent_background = t
    end,
    aki = function(t)
      _G.aki_config.transparent_background = t
    end,
    adachi = function(t)
      _G.adachi_config.transparent_background = t
    end,
    gruvboxed = function(t)
      _G.gruvboxed_config.transparent_background = t
    end,
  },
  modules = {
    {
      'options',
      event = nil,
      opts = {
        cursorline = false,
        tab_width = 2,
        use_ripgrep = true,
        treesitter_folds = false,
      }
    },
    {
      'base',
      event = nil,
      opts = {
        file_associations = {
          { { '*.vim', '*.md' }, 'Remove line numbers', function()
            vim.opt_local.number = false
          end },
          { { '*.vto', '*.njk' }, '[Template Engine] set filetype html', function()
            vim.bo.filetype = 'html'
          end },
        },
      }
    },
    {
      'plugins',
      event = nil,
    },
    {
      'maps',
      event = 'UIEnter',
    },
    {
      'highlights',
      event = 'UIEnter',
    },
  },
}
