return {
  plugins = {
    pairs      = { opts = {} },
    align      = { opts = {} },
    comment    = {
      opts = {
        options = {
          -- Whether to ignore blank lines
          ignore_blank_line = false,
          -- Whether to recognize as comment only lines without indent
          start_of_line = false,
          -- Whether to ensure single space pad for comment parts
          pad_comment_parts = true,
        },
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = 'gc',

          -- Toggle comment on current line
          comment_line = 'gcc',

          -- Toggle comment on visual selection
          comment_visual = 'gc',

          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          textobject = 'gc',
        },
      },
      config = function(mod, opts)
        mod.setup(opts)
        keymaps.normal[{ 'SPC', '/' }] = { opts.mappings.comment_line, '' }
      end,
    },
    bracketed  = {
      opts = {
        -- First-level elements are tables describing behavior of a target:
        --
        -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
        --  For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
        --  Supply empty string `''` to not create mappings.
        --
        -- - <options> - table overriding target options.

        buffer     = { suffix = 'b', options = {} },
        comment    = { suffix = 'g', options = {} },
        conflict   = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },
        file       = { suffix = 'f', options = {} },
        indent     = { suffix = 'i', options = {} },
        jump       = { suffix = 'j', options = {} },
        location   = { suffix = 'l', options = {} },
        oldfile    = { suffix = 'o', options = {} },
        quickfix   = { suffix = 'q', options = {} },
        treesitter = { suffix = 't', options = {} },
        undo       = { suffix = 'u', options = {} },
        window     = { suffix = 'w', options = {} },
        yank       = { suffix = 'y', options = {} },
      },
    },
    files      = {
      opts = {
        options = {
          use_as_default_explorer = false,
        },
        windows = {
          -- Maximum number of windows to show side by side
          max_number = math.huge,
          -- Whether to show preview of file/directory under cursor
          preview = false,
          -- Width of focused window
          width_focus = 50,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 25,
        },
      },
      config = function(mod, opts)
        mod.setup(opts)
        local keymaps = require 'keymaps'.setup()
        keymaps.normal['<space>sp'] = { require 'mini.files'.open, 'Open Files', group = "UI" }
      end
    },
    hipatterns = {
      opts = {
        groups = {
          fixme = { { "FIX", "FIXME" }, "@comment.fix" },
          warn = { { "WARN", "WARNING" }, "@comment.warning" },
          perf = { { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE" }, "@comment.fix" },
          todo = { { "TODO" }, "@comment.todo" },
          note = { { "NOTE", "INFO" }, "@comment.note" },
          test = { { "TEST", "TESTING" }, "@comment.todo" },
          test_passed = { { "PASSED" }, "healthSucces" },
          test_failed = { { "FAILED" }, "healthError" },
        },
      },
      config = function(hipatterns, opts)
        local highlighters = {
          -- [!NOTE] highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        }
        for m, v in pairs(opts.groups) do
          local higroup = v[2]
          local matches = v[1]
          for _, match in ipairs(matches) do
            highlighters[m .. '_' .. match] = { pattern = "%f[%w]()" .. match .. "()%f[%W]", group = higroup }
            highlighters['note_' .. m .. '_' .. match] = { pattern = "[[]!*" .. match .. "[]]", group = higroup .. ".emphasis" }
          end
        end
        hipatterns.setup {
          highlighters = highlighters,
        }
      end,
    },
    move       = {
      opts = {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move current line in Normal mode
          line_left = '',
          line_right = '',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },

        -- Options which control moving behavior
        options = {
          -- Automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      },
    },
    surround   = {
      opts = {
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `:h MiniSurround.config`.
        custom_surroundings = nil,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 300,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add = 'S',           -- Add surrounding in Normal and Visual modes
          delete = 'ds',       -- Delete surrounding
          find = 'sf',         -- Find surrounding (to the right)
          find_left = 'sF',    -- Find surrounding (to the left)
          highlight = '',      -- Highlight surrounding
          replace = 'cs',      -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = '',    -- Suffix to search with "prev" method
          suffix_next = '',    -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `:h MiniSurround.config`.
        search_method = 'cover',

        -- Whether to disable showing non-error feedback
        silent = false,
      },
    },
    trailspace = { opts = {} },
    visits     = {
      opts = {
        silent = true,
        track = {
          delay = 200,
        },
      },
      config = function(mod, opts)
        mod.setup(opts)

        local prefix = '<space>g'

        local toggle_label = function()
          local label = 'tag'

          local _labels = mod.list_labels(nil)
          local toggled = false
          for _, v in ipairs(_labels) do
            if v == label then
              toggled = true
            end
          end

          if toggled then
            mod.remove_label(label, nil)
          else
            mod.add_label(label, nil)
          end
        end

        keymaps.normal[{ prefix, 't' }] = { function()
          toggle_label()
        end, '[T]oggle label for current buffer' }

        keymaps.normal[{ prefix, 'f' }] = { function()
          mod.select_path()
        end, '[F]ind buffers with label' }

        keymaps.normal[{ prefix, 'r' }] = { function()
          mod.select_path()
        end, 'Find [R]ecent buffers' }
      end
    },
  },
}
