local M = {}

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.cmd('startinsert')
  end,
  desc = 'start insert mode on TermOpen',
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
  end,
  desc = 'remove line numbers',
})

-- RPC Server

local is_server = function()
  local sl = vim.fn.serverlist()
  return vim.tbl_contains(sl, '/tmp/vi.pipe')
end

local quit_server = function()
  if is_server() then
    vim.fn.system { 'rm', '/tmp/vi.pipe' }
  end
end

local server_au_id = vim.api.nvim_create_augroup('RPCServer', { clear = true })
vim.api.nvim_create_autocmd('UIEnter', {
  once = true,
  group = server_au_id,
  callback = function()
    if is_server() then
      vim.api.nvim_create_autocmd('VimLeavePre', {
        once = true,
        group = server_au_id,
        callback = function()
          quit_server()
        end
      })
    end
  end
})

-- mkdir path

vim.cmd [[
function s:Mkdir()
  let dir = expand('%:p:h')

  if dir =~ '://'
    return
  endif

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

autocmd BufWritePre * call s:Mkdir()]]

-- white space
vim.cmd [[
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

nnoremap <leader>x :<C-U>call StripTrailingWhitespace()<CR>
]]

-- statusline
vim.api.nvim_create_user_command('ToggleStatusLine', function(_)
  if vim.o.laststatus == 0 then
    vim.opt.laststatus = 3
    vim.opt.cmdheight = 1
  else
    vim.opt.laststatus = 0
    vim.opt.cmdheight = 0
  end
end, {})

vim.cmd [[
function! Get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
]]

vim.api.nvim_create_user_command('SubstituteSelection', function (_)
  local select = vim.fn.Get_visual_selection()
  vim.ui.input({ prompt = "replace `".. select .."` with >" }, function (input)
    if not input then return end
    vim.cmd("%s/"..select.."/"..input.."/g")
    vim.cmd('norm ``')
  end)
end, {})

-- netrw
vim.g.netrw_liststyle = 3
vim.cmd [[hi! link netrwTreeBar NonText]]

---@alias BaseConfigEnum 'file_associations'
---@alias BaseConfig { [BaseConfigEnum]: any }

--- Setup options
---@param opts BaseConfig
function M.setup(opts)
  -- { { patterns... }, description, callback }
  for _, item in ipairs(opts.file_associations) do
    if not type(item[1]) == 'table' then
      goto continue
    end
    if not type(item[2]) == 'string' then
      goto continue
    end
    if not type(item[3]) == 'function' then
      goto continue
    end
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = item[1],
      callback = item[3],
      group = core.group_id,
      desc = item[2],
    })
    ::continue::
  end
end

return M
