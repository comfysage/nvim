-- config.init
return require 'core'.setup {
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
        'highlights',
        event = 'UIEnter',
        opts = {
          fix = function()
            vim.cmd [[ hi clear SpellCap ]]

            if vim.g.neovide then
              local alpha = function()
                return string.format("%x", math.floor(255 * vim.g.transparency or 0.0))
              end
              local bg_color = '#' .. vim.api.nvim_get_hl(0, { name = 'Normal' }).bg

              vim.g.neovide_background_color = bg_color .. alpha()
            end

            -- notes

            local groups = {
              fixme   = { "Fixme", vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }) },
              todo    = { "Todo", vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }) },
              note    = { "Note", vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }) },
              success = { "Success", vim.api.nvim_get_hl(0, { name = "DiagnosticOk" }) },
              failure = { "Failure", vim.api.nvim_get_hl(0, { name = "DiagnosticError" }) },
            }
            for _, v in pairs(groups) do
              vim.api.nvim_set_hl(0, v[1], { fg = v[2].fg })
              vim.api.nvim_set_hl(0, v[1] .. 'Note', { fg = v[2].fg, reverse = true })
            end
          end
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
            { 'find files', 'SPC SPC', function() require 'core.plugin.telescope'.space() end },
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
