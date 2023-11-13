return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { { "prettierd", "prettier" }, "trim_whitespace" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },

        nix = { "nix_fmt" },
      },
      formatters = {
        nix_fmt = {
          command = "nix fmt",
        },
      },
    },
    keys = {
      { '<M-F>' },
    },
    config = function(_, opts)
      require 'conform'.setup(opts)
      keymaps.normal['<M-F>'] = { require 'conform'.format, 'Format Current Document' }
    end
  }
}
