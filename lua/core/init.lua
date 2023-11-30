require 'core.load'
require 'core.plugin.globals'

local parts = require 'core.parts'

---@alias Module 'options'|'highlights'|'base'|'maps'|'plugins'
---@alias Modules { [Module]: table }

---@class Config
---@field colorscheme string
---@field transparent_background boolean
---@field transparent_fn { [string]: function(bool) }
---@field modules Modules

---@class Core
---@field config Config
---@field group_id integer

local M = {}

---@type Core
---@diagnostic disable: missing-fields
_G.core = _G.core or {}

---@type Config
M.default_config = {
  colorscheme = "habamax", -- or "zaibatsu" or "retrobox"
  transparent_background = false,
  transparent_fn = {},
  modules = {},
}

---@type Config
_G.core.config = vim.tbl_deep_extend('force', M.default_config, _G.core.config or {})

---@param config Config
function M.setup(config)
  if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end
  core.group_id = vim.api.nvim_create_augroup("config:" .. CONFIG_MODULE, {})

  _G.core.config = vim.tbl_deep_extend('force', _G.core.config, config or {})

  M.load()
end

--- load config
function M.load()
  vim.notify('loading config', vim.log.levels.DEBUG)

  parts.modules {}

  parts.colorscheme {}

  _G.transparent_background_fn = core.config.transparent_fn
  vim.api.nvim_create_user_command('ToggleTransparentBG', function ()
    _G.toggle_transparent_background()
  end, {})

  toggle_transparent_background(core.config.transparent_background)

  parts.platform {}
end

function M.reload()
  vim.notify('reloading config', vim.log.levels.DEBUG)

  parts.modules {
    plugins = false,
  }

  parts.colorscheme {}

  _G.transparent_background_fn = core.config.transparent_fn
  vim.api.nvim_create_user_command('ToggleTransparentBG', function ()
    _G.toggle_transparent_background()
  end, {})

  toggle_transparent_background(core.config.transparent_background)

  parts.platform {}
end

return M
