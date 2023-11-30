local parts = {}

---@param _modules { [Module]: boolean }
function parts.modules(_modules)
  -- preload keymaps module
  local ok, keymaps = pcall (require, 'keymaps')
  if ok then keymaps.setup {} end

  for _, spec in ipairs(core.config.modules) do
    ---@type Module
    local _mod = spec[1]
    local _opts = spec.opts or {}
    local _source = CONFIG_MODULE .. '.' .. _mod

    if _modules[_mod] and _modules[_mod] == false then
      goto continue
    end

    ---@param source string
    ---@param mod Module
    ---@param opts table
    local callback = function(source, mod, opts)
      local status, result = pcall(require, source)
      if not status then
        vim.notify("failed to load " .. source .. "\n\t" .. result, vim.log.levels.ERROR)
        return
      end
      if type(result) == 'table' then
        if result.setup then
          result.setup(opts)
        end
        if mod == 'highlights' then
          vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
            group = core.group_id,
            callback = function()
              result.fix()
            end
          })
        end
      end
    end
    if spec.event then
      vim.api.nvim_create_autocmd({ spec.event }, {
        group = core.group_id,
        once = true,
        callback = function()
          callback(_source, _mod, _opts)
        end,
      })
    else
      callback(_source, _mod, _opts)
    end
      ::continue::
  end
end

function parts.colorscheme(_)
  vim.cmd.colorscheme(core.config.colorscheme)
  local ok, _ = pcall(vim.cmd.colorscheme, core.config.colorscheme)
  if not ok then
    vim.notify("couldn't load colorscheme", vim.log.levels.ERROR)
  end

  vim.api.nvim_create_autocmd({ 'UIEnter' }, {
    group = core.group_id,
    once = true,
    callback = function()
      vim.api.nvim_exec_autocmds('ColorScheme', {})
    end
  })
end

function parts.platform(_)
  local has = vim.fn.has
  local is_mac = has 'macunix'
  local is_win = has 'win32'
  local is_neovide = vim.g.neovide

  if is_mac then
    require 'config.macos'
  end
  if is_win then
    require 'config.windows'
  end
  if is_neovide then
    require 'config.neovide'
  end
end

return parts
