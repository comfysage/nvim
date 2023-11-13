
-- wsl yank support
vim.cmd [[
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' && v:event.regname ==# '*' | echo v:event | call system(s:clip, @0) | endif
  augroup END
endif
]]
