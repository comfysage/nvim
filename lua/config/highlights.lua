-- termguicolors
vim.opt.termguicolors = true
-- foldcolumn off
vim.opt.foldcolumn = "0"
-- global statusline
vim.opt.laststatus = 3

-- fold chars
vim.opt.fillchars:append { fold = " ", foldclose = ">" }
-- endofbuffer chars
vim.opt.fillchars:append { eob = " " }

vim.opt.listchars:append { tab = "> ", trail = "-", nbsp = "+", space = "·" }

vim.opt.background = "dark"

-- scheme specific

-- GruvboxTheme {{{

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_improved_strings = 0
vim.g.gruvbox_transparent_background = 1

-- }}}

-- helpers

vim.cmd([[ command! Highlights source $VIMRUNTIME/syntax/hitest.vim ]])

vim.cmd([[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  let s:val = map(synstack(line("."), col(".")), 'synIDattr(v:val, "name")')
  echo s:val
  let s:hl = synIDattr(synIDtrans(hlID(s:val[len(s:val) - 1])), "name")
  echohl s:hl | echo s:hl | echohl None
endfunc ]])

vim.api.nvim_create_user_command('SynStack', function()
  if not vim.fn.exists("*synstack") then
    return
  end
  local val = vim.fn.map(vim.fn.synstack(vim.fn.line("."), vim.fn.col(".")), 'synIDattr(v:val, "name")')
  local hl = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(val[#val])), "name")
  P(val)
  vim.cmd('echohl ' .. hl .. ' | echo "' .. hl .. '" | echohl None')
end, {})

vim.keymap.set("n", "<leader>sp", ":call SynStack()<CR>")

return {
  fix = function ()
    vim.cmd [[ hi clear SpellCap ]]

    if vim.g.neovide then
      local alpha = function ()
        return string.format("%x", math.floor(255 * vim.g.transparency or 0.0))
      end
      local bg_color = '#' .. vim.api.nvim_get_hl(0, { name = 'Normal' }).bg

      vim.g.neovide_background_color = bg_color .. alpha()
    end

    -- notes

    local groups = {
      fixme = { "Fixme", vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }) },
      todo  = { "Todo", vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }) },
      note  = { "Note", vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }) },
      success  = { "Success", vim.api.nvim_get_hl(0, { name = "DiagnosticOk" }) },
      failure  = { "Failure", vim.api.nvim_get_hl(0, { name = "DiagnosticError" }) },
    }
    for _, v in pairs(groups) do
      vim.api.nvim_set_hl(0, v[1], { fg = v[2].fg })
      vim.api.nvim_set_hl(0, v[1] .. 'Note', { fg = v[2].fg, reverse = true })
    end

  end
}
