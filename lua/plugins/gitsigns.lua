return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs                        = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      },
      signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir                 = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked          = true,
      current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<summary>, <author_time:%Y-%m-%d> ~ <author>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil,   -- Use default
      max_file_length              = 40000, -- Disable if file is longer than this (in lines)
      preview_config               = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm                         = {
        enable = false
      },
      on_attach                    = function(_)
      end
    },
    config = function(_, opts)
      local status, gs = pcall(require, 'gitsigns')
      if not status then return end
      gs.setup(opts)

      -- Navigation
      keymaps.normal[']c'] = { function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, '[Git] Jump to the next hunk in the current buffer', group = 'Git', { expr = true } }

      keymaps.normal['[c'] = { function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, '[Git] Jump to the previous hunk in the current buffer', group = 'Git', { expr = true } }

      -- Actions
      keymaps.normal[',hs'] = { gs.stage_hunk, '[Git] stage current hunk', group = 'Git' }
      keymaps.visual[',hs'] = { gs.stage_hunk, '[Git] stage current hunk', group = 'Git' }
      keymaps.normal[',hr'] = { gs.reset_hunk, '[Git] reset the lines of the current hunk', group = 'Git' }
      keymaps.visual[',hr'] = { gs.reset_hunk, '[Git] reset the lines of the current hunk', group = 'Git' }
      keymaps.normal[',hS'] = { gs.stage_buffer, '[Git] Stage Buffer', group = 'Git' }
      keymaps.normal[',hu'] = { gs.undo_stage_hunk, '[Git] Undo last call to stage_hunk()', group = 'Git' }
      keymaps.normal[',hR'] = { gs.reset_buffer, '[Git] Reset the lines of all hunks in the buffer', group = 'Git' }
      keymaps.normal[',hp'] = { gs.preview_hunk, '[Git] Preview Hunk', group = 'Git' }
      keymaps.normal[',hb'] = { function() gs.blame_line { full = true } end,
        '[Git] Run git blame on the current line and show the results', group = 'Git' }
      keymaps.normal[',tb'] = { gs.toggle_current_line_blame, '[Git] Toggle Current Line Blame', group = 'Git' }
      keymaps.normal[',hd'] = { gs.diffthis, '[Git] vimdiff on current file', group = 'Git' }
      keymaps.normal[',hD'] = { function() gs.diffthis('~') end, '[Git] vimdiff on current file with base ~', group = 'Git' }
      keymaps.normal[',td'] = { gs.toggle_deleted, '[Git] Toggle show_deleted', group = 'Git' }

      -- Text object
      keymaps.visual['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', '[Git] Select [I]nside [H]unk', group = 'Git' }
    end
  }
}
