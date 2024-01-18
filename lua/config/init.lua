-- config.init
return {
  colorscheme = 'evergarden',
  transparent_background = false,
  config_module = 'config',
  modules = {
    ['core'] = {
      {
        'options',
        event = nil,
        opts = {
          cursorline = false,
          number = true,
          tab_width = 2,
          scrolloff = 5,
          use_ripgrep = true,
          treesitter_folds = false,
          loaded_plugins = {'netrw'},
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
        'keymaps',
        opts = {
          leader = 'SPC',
          localleader = ' m',
        },
      },
      {
        'ui',
        opts = {
          general = {
            colorscheme = 'everforest',
          },
        },
      },
      {
        'highlights',
        event = 'UIEnter',
        opts = 'config.highlights',
      },
      {
        'treesitter',
        opts = {
          ensure_installed = { 'bash', 'rust', 'go' },
        },
      },
      {
        'luasnip',
        opts = {
          import_languages = { 'rust', 'go', 'lua', 'c', 'cpp', 'html', 'js', 'bash' },
        },
      },
      {
        'cmp',
        opts = {
          completion_style = 'tab',
        },
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
