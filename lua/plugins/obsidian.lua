return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre " .. ENV('KITCHEN') .. "/botanic/*.md",
    "BufNewFile " .. ENV('KITCHEN') .. "/botanic/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = ENV('KITCHEN') .. "/botanic",
    notes_subdir = 'kaze',
    completion = {
      new_notes_location = "notes_subdir",
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      -- local suffix = ""
      -- if title ~= nil then
      --   -- If title is given, transform it into valid file name.
      --   suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      -- else
      --   -- If title is nil, just add 4 random uppercase letters to the suffix.
      --   for _ = 1, 4 do
      --     suffix = suffix .. string.char(math.random(65, 90))
      --   end
      -- end
      -- return tostring(os.time()) .. "-" .. suffix
      return title
    end,
  },
}
