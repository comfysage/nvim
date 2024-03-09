-- config.init
return {
  colorscheme = 'twilight-moon',
  transparent_background = false,
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
            { { '*.json' }, 'adjust conceal level', function(opts)
              vim.api.nvim_buf_call(opts.buf, function ()
                local win = vim.api.nvim_get_current_win()
                vim.wo[win].conceallevel = 1
              end)
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
            devicons = false,
          },
        },
      },
      {
        'highlights',
        event = 'UIEnter',
        opts = 'custom.highlights',
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
          menu_style = 'nyoom',
        },
      },
      {
        'lsp',
        event = 'UIEnter',
        opts = 'custom.lsp',
      },
      {
        'telescope',
        event = 'UIEnter',
        opts = {
          use_fzf = true,
          theme = 'main',
          config = {},
        },
      },
      {
        'lualine',
        event = 'UIEnter',
        opts = {
          options = {
            separators = 'round',
          },
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
        },
      },
      {
        'mini',
        opts = 'custom.lib',
      },
    },
    ['custom'] = {
      {
        'options',
        event = nil,
      },
      {
        'base',
        event = nil,
      },
      {
        'config.highlights',
        event = 'UIEnter',
      },
      {
        'maps',
        event = 'UIEnter',
      },
    },
  },
}
