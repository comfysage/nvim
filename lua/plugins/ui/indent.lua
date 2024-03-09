return {
  'lukas-reineke/indent-blankline.nvim', event = 'BufAdd',
  opts = {
    indent = {
      highlight = {
        "@ibl.indent.char.1",
        "@ibl.indent.char.2",
        "@ibl.indent.char.3",
        "@ibl.indent.char.4",
        "@ibl.indent.char.5",
        "@ibl.indent.char.6",
        "@ibl.indent.char.7",
        "@ibl.indent.char.8",
        "@ibl.indent.char.9",
        "@ibl.indent.char.10",
        "@ibl.indent.char.11",
        "@ibl.indent.char.12",
      }
    },
    scope = {
      enabled = false,
    },
  },
  config = function(_, opts)
    for _, hi_name in ipairs(opts.indent.highlight) do
      local hi = vim.api.nvim_get_hl(0, { name = hi_name })
      if vim.tbl_isempty(hi) then
        vim.api.nvim_set_hl(0, hi_name, { link = "Comment" })
      end
    end

    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      callback = function()
        for _, hi_name in ipairs(opts.indent.highlight) do
          local hi = vim.api.nvim_get_hl(0, { name = hi_name })
          if vim.tbl_isempty(hi) then
            vim.api.nvim_set_hl(0, hi_name, { link = "Comment" })
          end
        end
      end
    })

    require 'ibl'.setup(opts)
  end
}
