return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
  },
  opts = {},
  config = function (_, opts)
    local status, neogit = pcall(require, 'neogit')
    if not status then return end

    neogit.setup(opts)

    keymaps.normal['<space>sgf'] = { function ()
      require 'neogit'.open { kind = "vsplit" }
    end, 'show git status', group = 'git' }
    keymaps.normal['<space>sgc'] = { function ()
      require 'neogit'.open { "commit", kind = "vsplit" }
    end, 'show git commit window', group = 'git' }

  end
}
