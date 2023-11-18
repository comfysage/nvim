return { {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'lualine'.setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',-- { left = '', right = '' },
        section_separators = '',-- { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = { 'branch', function() return vim.fn.expand('%:.:h') end, 'diff', { 'diagnostics', symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' } } },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { function ()
          local w_count = vim.fn.wordcount()
          local count = 0
          if w_count['visual_words'] then
            count = w_count['visual_words']
          else
            count = w_count['words']
          end
          if count == 0 then
            return ""
          end
          return count
        end },
        lualine_z = { function()
          local row, column = unpack(vim.api.nvim_win_get_cursor(0))
          return "L" .. row .. ":" .. column
        end }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },

        lualine_x = { function() return vim.fn.expand('%l:%L') end },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},

      winbar = {},
      inactive_winbar = {},

      extensions = {}
    }
  end
} }
