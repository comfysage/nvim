-- local bind = function(bind)
--   if #bind > 2 then
--     if bind[3].unique then
--       for _, k in pairs(vim.api.nvim_get_keymap("n")) do
--         if k.lhs == bind[1] then
--           return
--         end
--       end
--     end
--   end
--   vim.keymap.set("n", bind[1], bind[2], bind[3])
-- end

-- bind { "s", "'", { remap = true } }

-- if vim.g.smoothie_enabled then
--   bind { "ss", '<cmd>call smoothie#do("zz") <CR>', { remap = false } }
--   bind { "sa", '<cmd>call smoothie#do("zt") <CR>', { remap = false } }
--   bind { "sd", '<cmd>call smoothie#do("zb") <CR>', { remap = false } }
-- else
--   bind { "ss", "zz", { remap = false } }
--   bind { "sa", "zt", { remap = false } }
--   bind { "sd", "zb", { remap = false } }
-- end

keymaps.normal["s{"] = { '[{', 'Goto previous paragraph', { remap = false } }
keymaps.normal["s}"] = { ']}', 'Goto next paragraph', { remap = false } }

local vjoin = function(args, sub)
  local str = ""
  for i, s in pairs(args) do
    str = str .. s
    if i < #args then
      str = str .. sub
    end
  end
  return str
end

local createRg = function(args)
  return '\\(' .. vjoin(args, '\\|') .. '\\)'
end

local paired = createRg({ '(', ')', '{', '}', '\\[', '\\]' })

keymaps.normal["sfl"] = { function() vim.fn['search'](paired, 'Ws') end, 'Goto next scope', { remap = false } }
keymaps.normal["sfh"] = { function() vim.fn['search'](paired, 'Wsb') end, 'Goto previous scope', { remap = false } }
