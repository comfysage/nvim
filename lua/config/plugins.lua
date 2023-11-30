-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- source on write
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PlugCompile',
  group = packer_group,
  pattern = 'plugins.lua',
})

local root_path = vim.fn.stdpath("data") .. "/lazy"
local is_bootstrap = false

local lazypath = root_path .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  is_bootstrap = true
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  root = root_path, -- directory where plugins will be installed
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  lockfile = CR_PATH 'nvim' .. "/lazy-lock.json", -- lockfile generated after running update.
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 90, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'rounded',
    icons = {
      cmd = "! ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = "~ ",
      runtime = "0 ",
      source = "R ",
      start = ">",
      task = "O ",
      list = {
        "-",
        "*",
        "*",
        "-",
      },
    },
  },
}

-- custom Plug commands
-- local alias = function (verb)
--   local cverb = string.upper(string.sub(verb, 1,1)) .. string.sub(verb, 2)
--   vim.api.nvim_create_user_command('Plug' .. cverb, function(_)
--     (vim.tbl_contains(require 'lazy', 'compile') and require 'lazy'['compile'] or function() end)()
--   end, {})
-- end
-- alias 'sync'
-- alias 'clean'
-- alias 'install'
-- alias 'update'
-- alias 'compile'

if is_bootstrap then
  -- require('packer').sync()
end

vim.notify('loading plugins.', vim.log.levels.DEBUG)

local status, lz = pcall(require, 'lazy')
if status then
  pcall(lz.setup, 'plugins', opts)
end

keymaps.normal['<space>sl'] = { function() require 'lazy'.home() end, 'Open Lazy' }
