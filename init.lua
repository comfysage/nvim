local rootpath = vim.fn.stdpath("data") .. "/core"
local sentinelpath = rootpath .. "/sentinel"
vim.opt.rtp:prepend(sentinelpath)

local ok, core = pcall(require, 'core')
if not ok then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/crispybaccoon/sentinel.nvim.git",
    sentinelpath,
  })
end

require 'config'
