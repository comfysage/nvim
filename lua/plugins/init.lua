return {
  { import = 'plugins.std' },
  { import = 'plugins.git' },
  { import = 'plugins.ui' },
  { import = 'plugins.colorscheme' },
  -- the plugin manager can manage itself
  { 'folke/lazy.nvim', branch = 'stable' },

  -- {
  --   'francoiscabrol/ranger.vim',
  --   dependencies = { 'rbgrouleff/bclose.vim' }
  -- },

  { 'junegunn/fzf',    build = ':call fzf#install()', lazy = true },
  -- 'junegunn/fzf.vim',

  -- 'jiangmiao/auto-pairs',
  --[[ {
    'windwp/nvim-autopairs',
    opts = {}
  }, ]]
  { 'antonk52/vim-tabber', lazy = true },
  'psliwka/vim-smoothie',
  -- 'junegunn/vim-easy-align',
  -- 'junegunn/vim-peekaboo',

  -- { 'vim-airline/vim-airline' },
  --[[ { 'akinsho/bufferline.nvim',
  tag = "v3.*",
  requires = 'nvim-tree/nvim-web-devicons' } ]]

  -- 'ap/vim-css-color',
  -- { 'norcalli/nvim-colorizer.lua', ft = { 'css', 'scss' } },

  -- IDE
  { 'mattn/emmet-vim', ft = { 'css', 'scss', 'html', 'tsx' } },
  -- 'nvim-tree/nvim-web-devicons', -- Icons for Telescope

  -- 'pangloss/vim-javascript',
  -- { 'prettier/vim-prettier', build = 'npm install --frozen-lockfile --production', lazy = true },
  -- 'airblade/vim-gitgutter',
  { 'tpope/vim-fugitive', enabled = false },
  -- {
  --   'sindrets/diffview.nvim',
  --   dependencies = 'nvim-lua/plenary.nvim'
  -- },
  { 'sheerun/vim-polyglot', enabled = false },
  -- 'ThePrimeagen/refactoring.nvim',
  {
    'simrat39/symbols-outline.nvim',
    opts = {
      position = 'left',
    },
    ft = { 'markdown' },
    config = function (_, opts)
      local status, so = pcall(require, 'symbols-outline')

      so.setup(opts)

      keymaps.normal['<space>st'] = { so.toggle_outline, "Toggle Symbols Outline", group = "UI" }
    end
  },

  -- 'elkowar/yuck.vim',

  -- 'tpope/vim-surround',
  'tpope/vim-vinegar',
  { 'tpope/vim-markdown', ft = 'markdown' },
  {
    'mickael-menu/zk-nvim',
    opts = {
      -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
      -- it's recommended to use "telescope" or "fzf"
      picker = 'telescope',

      lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
          cmd = { 'zk', 'lsp' },
          name = 'zk_lsp',
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    },
    config = function(_, opts)
      require 'zk'.setup(opts)
    end,
    ft = 'markdown'
  },

  -- { 'junegunn/goyo.vim',      ft = 'markdown' },
  -- { 'junegunn/limelight.vim', ft = 'markdown' },
  -- 'folke/zen-mode.nvim',
  -- 'folke/twilight.nvim',

  {
    'numToStr/FTerm.nvim', name = 'fterm',
    opts = {
      ---Filetype of the terminal buffer
      ---@type string
      ft = 'FTerm',

      ---Command to run inside the terminal
      ---NOTE: if given string[], it will skip the shell and directly executes the command
      ---@type fun():(string|string[])|string|string[]
      -- cmd = os.getenv('SHELL'),

      ---Neovim's native window border. See `:h nvim_open_win` for more configuration options.
      border = 'rounded',

      ---Close the terminal as soon as shell/command exits.
      ---Disabling this will mimic the native terminal behaviour.
      ---@type boolean
      auto_close = true,

      ---Highlight group for the terminal. See `:h winhl`
      ---@type string
      hl = 'Normal',

      ---Transparency of the floating window. See `:h winblend`
      ---@type integer
      blend = 0,

      ---Object containing the terminal window dimensions.
      ---The value for each field should be between `0` and `1`
      ---@type table<string,number>
      dimensions = {
        height = 0.8, -- Height of the terminal window
        width = 0.6, -- Width of the terminal window
        x = 0.5, -- X axis of the terminal window
        y = 0.5, -- Y axis of the terminal window
      },

      ---Replace instead of extend the current environment with `env`.
      ---See `:h jobstart-options`
      ---@type boolean
      -- clear_env = false,

      ---Map of environment variables extending the current environment.
      ---See `:h jobstart-options`
      ---@type table<string,string>|nil
      -- env = nil,

      ---Callback invoked when the terminal exits.
      ---See `:h jobstart-options`
      ---@type fun()|nil
      -- on_exit = nil,

      ---Callback invoked when the terminal emits stdout data.
      ---See `:h jobstart-options`
      ---@type fun()|nil
      -- on_stdout = nil,

      ---Callback invoked when the terminal emits stderr data.
      ---See `:h jobstart-options`
      ---@type fun()|nil
      -- on_stderr = nil,
    },
    config = function (_, opts)
      require 'FTerm'.setup (opts)
      keymaps.normal[',w'] = { '<CMD>lua require("FTerm").toggle()<CR>', 'Open Floating Terminal' }
      vim.keymap.set('t', ',w', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end
  },

  -- Lua
  'nvim-lua/plenary.nvim', -- utils
  'nvim-lua/popup.nvim',
  -- { 'numToStr/Comment.nvim', name = 'commentary' },
  {
    'folke/todo-comments.nvim',
    enabled = false,
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require 'todo-comments'.setup {
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = "! ",                                -- icon used for the sign, and in search results
            color = "error",                            -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = "/ ", color = "info" },
          WARN = { icon = "! ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "* ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = ". ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "* ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#FFA89A" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBB8B" },
          info = { "DiagnosticInfo", "#FFCCAE" },
          hint = { "DiagnosticHint", "#FFFFAA" },
          default = { "Identifier", "#AACCFF" },
          test = { "Identifier", "#AACCFF" }
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      }
    end
  },

  -- LSP
  -- 'glepnir/lspsaga.nvim',
  -- 'folke/trouble.nvim',

  {
    'crispybaccoon/sayama.nvim',
    lazy = true,
    config = function()
      require 'sayama'.setup {
        dir = ENV('KITCHEN') .. '/pan/code-examples'
      }
    end
  },

  { 'lewis6991/impatient.nvim', enabled = false },

  -- Colorschemes

  { 'sainnhe/everforest',          lazy = true },
  { 'arcticicestudio/nord-vim',    lazy = true },

  { 'sainnhe/gruvbox-material',    lazy = true },
  { 'catppuccin/nvim',             name = 'catppuccin', lazy = true },
  { 'joshdick/onedark.vim',        lazy = true },
  { 'cocopon/iceberg.vim',         lazy = true },
  { 'crispybaccoon/fantastic.vim', lazy = true },
  { 'crispybaccoon/dawn.vim',      lazy = true },
}
