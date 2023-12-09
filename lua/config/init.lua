-- config.init
return {
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
  config_module = 'config',
  modules = {
    ['core'] = {
      {
        'options',
        event = nil,
        opts = {
          cursorline = false,
          tab_width = 2,
          scrolloff = 5,
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
            { { '*' }, 'Use `q` to quit qf list', function(opts)
              if vim.bo[opts.buf].filetype == 'qf' then
                vim.keymap.set('n', 'q', ':quit<cr>', { buffer = opts.buf })
              end
            end },
          },
        }
      },
      {
        'highlights',
        event = 'UIEnter',
        opts = 'config.highlights',
      },
      {
        'telescope',
        event = 'UIEnter',
        opts = {
          use_fzf = true,
          config = {},
        },
      },
      {
        'dash',
        opts = {
          open_on_startup = true,
          header = {
            [[      )  (      ]],
            [[     (   ) )    ]],
            [[      ) ( (     ]],
            [[           )    ]],
            [[   ▟██████████▙ ]],
            [[ █▛██▛ ▟▛ ▟▛ ▟█ ]],
            [[ ▜▙█▛ ▟▛ ▟▛ ▟██ ]],
            [[   ▝██████████▛ ]],
            [[    ▝▀▀▀▀▀▀▀▀▀  ]],
          },
          buttons = {
            { 'find files', 'SPC SPC', function() require 'core.plugin.telescope'.picker.find_files() end },
          },
        },
      },
    },
    ['config'] = {
      {
        'options',
        event = nil,
      },
      {
        'base',
        event = nil,
      },
      {
        'plugins',
        event = nil,
        reload = false,
      },
      {
        'highlights',
        event = 'UIEnter',
      },
      {
        'maps',
        event = 'UIEnter',
      },
    },
  },
}
