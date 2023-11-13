return {
  'lukas-reineke/indent-blankline.nvim',
  opts = {
    indent = {
      highlight = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
        "IndentBlanklineIndent7",
        "IndentBlanklineIndent8",
        "IndentBlanklineIndent9",
        "IndentBlanklineIndent10",
        "IndentBlanklineIndent11",
        "IndentBlanklineIndent12",
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
