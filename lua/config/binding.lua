local M = {}

-- _G.keymaps = _G.keymaps or {}
-- _G.keymaps.__index = _G.keymaps.__index or {}
-- function _G.keymaps:append(item)
--   if #_G.keymaps:get(item.mode, item.lhs) > 0 then
--     return
--   end
--   table.insert(_G.keymaps.__index, item)
-- end
--
-- function _G.keymaps:get(mode, lhs)
--   local m = {}
--
--   for _, k in ipairs(_G.keymaps.__index) do
--     if k.mode == mode and k.lhs == lhs then
--       table.insert(m, k)
--     end
--   end
--
--   return m
-- end

---@param bind { [1]: string, [2]: string|function, [3]: { silent: boolean, unique: boolean }, [4]: string }
M.bind = function(bind)
  -- { map, cmd, opts, desc }
  if #bind > 2 then
    if bind[3].unique then
      for _, k in ipairs(vim.api.nvim_get_keymap("n")) do
        if k.lhs == bind[1] then
          return
        end
      end
    end
  end
  local mode = "n"
  local lhs = bind[1]
  local rhs = bind[2]
  local opts = MT(bind[3] or {}, { desc = bind[4] })
  opts.desc = opts.desc or nil
  -- _G.keymaps:append({
  --   mode = "n",
  --   lhs = bind[1],
  --   rhs = bind[2],
  --   opts = opts,
  --   desc = opts.desc or nil
  -- })
  vim.keymap.set(mode, lhs, rhs, opts)
end

---@alias mode 'n'|'v'|'i'

---@class Mapping
---@field mode mode
---@field lhs string
---@field rhs string
---@field buffer integer
---@field silent boolean
---@field desc string|nil

local function extend(s, l)
  if string.len(s) == l then return s end
  if string.len(s) > l then
    return string.sub(s, 1, l)
  end
  return s .. string.rep(" ", l - string.len(s))
end

-- M._parse = function()
--   local kmaps = _G.keymaps.__index
--   local str = {}
--
--   for _, k in ipairs(kmaps) do
--     local s = "|"
--     s = s .. " " .. extend(k.lhs, 14) .. "|"
--
--     local silentfl = "[silent]"
--     local descl = 20
--     local rhsl = 36
--     if k.opts.silent then
--       rhsl = rhsl - #silentfl
--     end
--     if k.desc then
--       s = s .. " " .. extend(k.desc, descl)
--       s = s .. " (" .. extend(k.rhs, rhsl - 2) .. ")"
--     else
--       s = s .. " " .. extend(k.rhs, rhsl + descl) .. " "
--     end
--
--     if k.opts.silent then
--       s = s .. silentfl
--     end
--
--     s = s .. "|"
--
--     table.insert(str, s)
--   end
--
--   return str
-- end

return M
