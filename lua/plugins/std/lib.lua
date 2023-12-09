LoadMiniLibs = function()
  local status, libs = SR ('config.lib')
  if not status then
    return
  end
  for l, c in pairs(libs) do
    local mod = require('mini.' .. l)
    if type(c) == "function" then
      mod.setup(c(mod))
    elseif type(c) == "table" then
      mod.setup(c)
    end
    if l == 'files' then
      local keymaps = require 'keymaps'.setup()
      keymaps.normal['<space>sp'] = { require 'mini.files'.open, 'Open Files', group = "UI" }
    end
  end
end

return {
  {
    'echasnovski/mini.nvim',
    config = function()
      LoadMiniLibs()
    end,
  },
}
