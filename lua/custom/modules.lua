-- custom.modules
return {
  ['ch'] = {
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
        loaded_plugins = { 'netrw' },
      },
    },
    {
      'base',
      event = nil,
      opts = {
        file_associations = {
          {
            { '*.vim', '*.md' },
            'Remove line numbers',
            function()
              vim.opt_local.number = false
            end,
          },
          {
            { '*.vto', '*.njk' },
            '[Template Engine] set filetype html',
            function()
              vim.bo.filetype = 'html'
            end,
          },
          {
            { '*.json' },
            'adjust conceal level',
            function(opts)
              vim.api.nvim_buf_call(opts.buf, function()
                local win = vim.api.nvim_get_current_win()
                vim.wo[win].conceallevel = 1
              end)
            end,
          },
        },
      },
    },
    {
      'keymaps',
      opts = {
        leader = 'SPC',
        localleader = 'm',
      },
    },
    {
      'ui',
      opts = { },
    },
    {
      'lazy',
      opts = {
        config = {
          dev = {
            path = '~/dev',
            fallback = true,
          },
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
        import_languages = {
          'rust',
          'go',
          'lua',
          'c',
          'cpp',
          'html',
          'js',
          'bash',
        },
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
      'null',
      opts = {
        sources = function(null)
          return {
            -- lua
            null.builtins.formatting.stylua,

            -- lint
            null.builtins.diagnostics.editorconfig_checker,

            -- build system
            null.builtins.diagnostics.checkmake,
            null.builtins.diagnostics.cmake_lint,

            -- git
            null.builtins.diagnostics.commitlint,

            -- format nix
            null.builtins.formatting.alejandra,
            -- prettier
            null.builtins.formatting.prettier.with({
              filetypes = { "css", "html", "json", "yaml", "markdown", "svelte" },
            }),

            -- format code blocks (markdown)
            null.builtins.formatting.cbfmt,

            -- ruby
            null.builtins.diagnostics.rubocop,
            null.builtins.formatting.rubocop,

            -- clang
            null.builtins.formatting.clang_format.with({
              filetypes = { "c", "cpp", "cs", "java" },
            })
          }
        end,
      }
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
          [[]],
          [[   ／l、      ]],
          [[ （ﾟ､ ｡ ７    ]],
          [[   l  ~ヽ     ]],
          [[   じしf_,)ノ ]],
          [[]],
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
      'config.options',
      event = nil,
    },
    {
      'config.base',
      event = nil,
    },
    {
      'config.highlights',
      event = 'UIEnter',
    },
    {
      'config.maps',
      event = 'UIEnter',
    },
  },
}
