lua <<EOF

vim.api.nvim_create_user_command('HeadingIncrement',
"<cmd>norm I#<CR>",
{ desc = "Increment header level" })
vim.api.nvim_create_user_command('HeadingDecrement',
"<cmd>s/^#//<CR>",
{ desc = "Decrement header level" })

vim.keymap.set('n', '<M-.>', '<cmd>HeadingIncrement<CR>', {})
vim.keymap.set('n', '<M-,>', '<cmd>HeadingDecrement<CR>', {})

vim.api.nvim_create_user_command('MarkdownFix', function()
vim.cmd('silent! %s/•/-/')
vim.cmd('silent! %s/“\\|”/"/g')
vim.cmd('silent! %s/^;\\s/### ')
vim.cmd('silent! %s/^@\\(.*\\)$/@\\1\\r/')
end,
{desc = {"Fix Markdown syntax"}})

