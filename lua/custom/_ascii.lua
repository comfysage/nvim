local map = {
  [' '] = {
    '  ',
    '  ',
  },
  a = {
    "▄▀█",
    "█▀█",
  },
  b = {
    "█▄▄",
    "█▄█",
  },
  c = {
    "█▀▀",
    "█▄▄",
  },
  d = {
    "█▀▄",
    "█▄▀",
  },
  e = {
    "█▀▀",
    "██▄",
  },
  f = {
    "█▀▀",
    "█▀░",
  },
  g = {
    "█▀▀",
    "█▄█",
  },
  h = {
    "█░█",
    "█▀█",
  },
  i = {
    " █ ",
    " █ ",
  },
  j = {
    " █ ",
    "▄▀ ",
  },
  k = {
    "█▄▀",
    "█░█",
  },
  l = {
    "█░░",
    "█▄▄",
  },
  m = {
    "█▀▄▀█",
    "█░▀░█",
  },
  n = {
    "█▄░█",
    "█░▀█",
  },
  o = {
    "█▀█",
    "█▄█",
  },
  p = {
    "█▀█",
    "█▀▀",
  },
  q = {
    "█▀█",
    "▀▀▄",
  },
  r = {
    "█▀█",
    "█▀▄",
  },
  s = {
    "█▀",
    "▄█",
  },
  t = {
    "▀█▀",
    "░█░",
  },
  u = {
    "█░█",
    "█▄█",
  },
  v = {
    "█░█",
    "▀▄▀",
  },
  w = {
    "█░█░█",
    "▀▄▀▄▀",
  },
  x = {
    "▀▄▀",
    "▄▀▄",
  },
  y = {
    "█▄█",
    "░█░",
  },
  z = {
    "▀█",
    "█▄",
  },
}

---@type fun(str: string): string
return function(str)
  local _str = vim.split(str, '')

  local new = {
    {},
    {},
  }

  for _, char in ipairs(_str) do
    local match = map[char:lower()]
    if not match then
      match = map[' ']
    end
    if #match ~= 2 then
      goto continue
    end

    local top = match[1]
    local bot = match[2]

    new[1][#new[1] + 1] = top
    new[2][#new[2] + 1] = bot
    ::continue::
  end

  local top = vim.fn.join(new[1], ' ')
  local bot = vim.fn.join(new[2], ' ')

  -- return vim.fn.join({ top, bot }, '\n')
  return { top, bot }
end
