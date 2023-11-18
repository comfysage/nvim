require 'comfy.globals'
require 'comfy.plugin.globals'

local M = {}

local default_colorscheme = "habamax" -- or "zaibatsu" or "retrobox"

---@alias Module 'options'|'highlights'|'base'|'maps'|'plugins'

---@class Config
---@field colorscheme string
---@field transparent_background boolean
---@field transparent_fn { [string]: function(bool) }
---@field modules { [Module]: table }

---@param config Config
function M.setup(config)
  if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end
  local group_id = vim.api.nvim_create_augroup("config:" .. CONFIG_MODULE, {})

  -- preload keymaps module
  local status, keymaps = pcall (require, 'keymaps' )
  if status then keymaps.setup() end

  for _, spec in ipairs(config.modules) do
    ---@type Module
    local _mod = spec[1]
    local _opts = spec.opts or {}
    local _source = CONFIG_MODULE .. '.' .. _mod

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
            callback = function()
              result.fix()
            end
          })
        end
      end
    end
    if spec.event then
      vim.api.nvim_create_autocmd({ spec.event }, {
        group = group_id,
        once = true,
        callback = function()
          callback(_source, _mod, _opts)
        end,
      })
    else
      callback(_source, _mod, _opts)
    end
  end

  vim.cmd("colorscheme " .. (config.colorscheme or default_colorscheme))
  if not pcall(vim.cmd.colorscheme, config.colorscheme or default_colorscheme) then
    vim.notify("couldn't load colorscheme", vim.log.levels.ERROR)
  end
  vim.api.nvim_create_autocmd({ 'UIEnter' }, {
    once = true,
    callback = function()
      vim.api.nvim_exec_autocmds('ColorScheme', {})
    end
  })

  if config.transparent_fn then
    _G.transparent_background_fn = config.transparent_fn
    vim.api.nvim_create_user_command('ToggleTransparentBG', function ()
      _G.toggle_transparent_background()
    end, {})
  end

  toggle_transparent_background(config.transparent_background)

  local has = vim.fn.has
  local is_mac = has 'macunix'
  local is_win = has 'win32'

  if is_mac then
    require 'config.macos'
  end
  if is_win then
    require 'config.windows'
  end
end

function _G.toggle_transparent_background(props)
  local is_transparent = false
  if props == nil then
    is_transparent = _G.transparent_background or is_transparent
  else
    is_transparent = not props
  end

  local colors = vim.g.colors_name

  if is_transparent then -- set to solid bg
    local fn = _G.transparent_background_fn[colors]
    fn(false)
    _G.transparent_background = false
  else -- set to transparent bg
    local fn = _G.transparent_background_fn[colors]
    fn(true)
    _G.transparent_background = true
  end
  vim.cmd.colorscheme(vim.g.colors_name)
end

return M
