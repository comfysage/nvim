local Util = require 'core.util'
local Config = require 'core.config'

---@class ComfyEventCore
local M = {}

---@class ComfyEventOpts
---@field exclude any|nil
---@field event any|nil
---@field group any|nil
---@field buffer any|nil
---@field data any|nil

-- Trigger an event. When a group is given, only the events in that group will be triggered.
-- When exclude is set, the events in those groups will be skipped.
---@param opts ComfyEventOpts
function M.trigger(opts)
  if opts.group or opts.exclude == nil then
    return M._trigger(opts)
  end
  local done = {} ---@type table<string,true>
  for _, autocmd in ipairs(vim.api.nvim_get_autocmds({ event = opts.event })) do
    local id = autocmd.event .. ":" .. (autocmd.group or "") ---@type string
    local skip = done[id] or (opts.exclude and vim.tbl_contains(opts.exclude, autocmd.group_name))
    done[id] = true
    if autocmd.group and not skip then
      opts.group = autocmd.group_name
      M._trigger(opts)
    end
  end
end

-- Trigger an event
---@param opts ComfyEventOpts
function M._trigger(opts)
  if Config.options.debug then
    Util.info({
      "# Firing Events",
      "  - **event:** " .. opts.event,
      opts.group and ("  - **group:** " .. opts.group),
      opts.buffer and ("  - **buffer:** " .. opts.buffer),
    })
  end
  Util.track({ event = opts.group or opts.event })
  Util.try(function()
    vim.api.nvim_exec_autocmds(opts.event, {
      buffer = opts.buffer,
      group = opts.group,
      modeline = false,
      data = opts.data,
    })
    Util.track()
  end)
end

return M
