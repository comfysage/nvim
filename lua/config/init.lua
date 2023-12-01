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
  modules = {
    ['core'] = {
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
    },
    ['config'] = {
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
        reload = false,
      },
      {
        'maps',
        event = 'UIEnter',
      },
    },
  },
}
