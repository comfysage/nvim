return {
  { import = 'plugins.std' },
  { import = 'plugins.git' },
  { import = 'plugins.ui' },
  { import = 'plugins.colorscheme' },


  { 'junegunn/fzf', build = ':call fzf#install()', lazy = true },

  {
    'simrat39/symbols-outline.nvim',
    ft = { 'markdown' },
    opts = {
      position = 'left',
      preview_bg_highlight = 'PmenuSel',
      fold_markers = { '', '' },
      symbols = {
        File = { icon = core.lib.icons.syntax.file, hl = "@text.uri" },
        Module = { icon = core.lib.icons.syntax.module, hl = "@namespace" },
        Namespace = { icon = core.lib.icons.syntax.namespace, hl = "@namespace" },
        Package = { icon = core.lib.icons.syntax.package, hl = "@namespace" },
        Class = { icon = core.lib.icons.syntax.class, hl = "@type" },
        Method = { icon = core.lib.icons.syntax.method, hl = "@method" },
        Property = { icon = core.lib.icons.syntax.property, hl = "@method" },
        Field = { icon = core.lib.icons.syntax.field, hl = "@field" },
        Constructor = { icon = core.lib.icons.syntax.constructor, hl = "@constructor" },
        Enum = { icon = core.lib.icons.syntax.enum, hl = "@type" },
        Interface = { icon = core.lib.icons.syntax.interface, hl = "@type" },
        Function = { icon = core.lib.icons.syntax.fn, hl = "@function" },
        Variable = { icon = core.lib.icons.syntax.variable, hl = "@constant" },
        Constant = { icon = core.lib.icons.syntax.constant, hl = "@constant" },
        String = { icon = core.lib.icons.syntax.string, hl = "@string" },
        Number = { icon = core.lib.icons.syntax.number, hl = "@number" },
        Boolean = { icon = core.lib.icons.syntax.boolean, hl = "@boolean" },
        Array = { icon = core.lib.icons.syntax.array, hl = "@constant" },
        Object = { icon = core.lib.icons.syntax.object, hl = "@type" },
        Key = { icon = core.lib.icons.syntax.field, hl = "@type" },
        Null = { icon = core.lib.icons.syntax.null, hl = "@type" },
        EnumMember = { icon = core.lib.icons.syntax.enummember, hl = "@field" },
        Struct = { icon = core.lib.icons.syntax.struct, hl = "@type" },
        Event = { icon = core.lib.icons.syntax.event, hl = "@type" },
        Operator = { icon = core.lib.icons.syntax.operator, hl = "@operator" },
        TypeParameter = { icon = core.lib.icons.syntax.typeparameter, hl = "@parameter" },
        Component = { icon = core.lib.icons.syntax.snippet, hl = "@function" },
        Fragment = { icon = core.lib.icons.syntax.snippet, hl = "@constant" },
      },
    },
    config = function(_, opts)
      local status, so = pcall(require, 'symbols-outline')

      so.setup(opts)

      core.lib.hl.apply {
        SymbolsOutlineConnector = { link = '@ibl.indent.char.1' },
      }

      keymaps.normal['<space>st'] =
        { so.toggle_outline, 'toggle symbols outline', group = 'show_ui' }
    end,
  },

  {
    'comfysage/sayama.nvim',
    event = 'BufAdd',
    config = function()
      require 'sayama'.setup {
        dir = ENV('HOME') .. '/dev/code-examples'
      }
    end
  },

  -- colorschemes

  { 'sainnhe/everforest', lazy = true },
  { 'sainnhe/gruvbox-material', lazy = true },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
  { 'joshdick/onedark.vim', lazy = true },
  { 'cocopon/iceberg.vim', lazy = true },
  { 'comfysage/fantastic.vim', dev = true, lazy = true },
  { 'comfysage/dawn.vim', dev = true, lazy = true },
}
