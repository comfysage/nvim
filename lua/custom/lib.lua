return {
  plugins = {
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
