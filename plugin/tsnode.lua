local M = {}

function M.get_node()
  return vim.treesitter.get_captures_at_cursor()
end

vim.api.nvim_create_user_command("TSNodes",
  function(props)
    P(props)
    P(M.get_node())
  end,
  { desc = "Get Treesitter nodes under cursor" })
