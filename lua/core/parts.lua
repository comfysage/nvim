local parts = {}

function parts.load_modules(_)
  if not core.config.modules['core'] then
    vim.notify('core modules are not defined.', vim.log.levels.ERROR)
    return
  end

  for main_mod, modules in pairs(core.config.modules) do
    if main_mod == 'core' then
      goto continue
    end
    vim.notify('loading ' .. main_mod .. ' modules.', vim.log.levels.DEBUG)

    parts._modules(main_mod, modules)

    ::continue::
  end
end

function parts.load(module, spec)
  if spec.loaded and spec.reload == false then
    vim.notify('skipping reloading module: ' .. module, vim.log.levels.DEBUG)
    return
  end

  ---@param source string
  ---@param mod ModuleName
  ---@param opts table
  local callback = function(source, opts)
    local status, result = pcall(require, source)
    if not status then
      vim.notify("failed to load " .. source .. "\n\t" .. result, vim.log.levels.ERROR)
      return
    end
    if type(result) == 'table' then
      if result.setup then
        result.setup(opts)
      end
    end
  end
  if spec.event then
    vim.api.nvim_create_autocmd({ spec.event }, {
      group = core.group_id,
      once = true,
      callback = function()
        callback(module, spec.opts)
      end,
    })
  else
    callback(module, spec.opts)
  end
end

---@param modules { [ModuleName]: boolean }
function parts._modules(mod, modules)
  for _, spec in ipairs(modules) do
    ---@type ModuleName
    local module = mod .. '.' .. spec.name

    parts.load(module, spec)
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
