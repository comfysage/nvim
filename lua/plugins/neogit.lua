return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  opts = {},
  config = function (_, opts)
    local status, neogit = pcall(require, 'neogit')
    if not status then return end

    neogit.setup(opts)

    keymaps.normal['<space>sf'] = { function ()
      require 'neogit'.open { kind = "vsplit" }
    end }
    keymaps.normal['<space>sc'] = { function ()
      require 'neogit'.open { "commit", kind = "vsplit" }
    end }

    vim.api.nvim_create_autocmd({ 'WinEnter' }, {
      pattern = { 'NeogitStatus' },
      callback = function ()
        require 'neogit'.refresh_manually()
      end
    })
  end
}
