return {
  'ThePrimeagen/git-worktree.nvim',
  event = "VeryLazy",
  opts = {
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "e .",
    clearjumps_on_change = true,
    autopush = false,
  },
  config = function(_, opts)
    require 'git-worktree'.setup(opts)

    local status, telescope = pcall(require, 'telescope')
    if status then
      telescope.load_extension 'git_worktree'
      keymaps.normal['<space>fw'] = {
        require 'telescope'.extensions.git_worktree.git_worktrees,
        group = 'Telescope',
        '[F]ind Git [W]orktree'
      }
      -- <Enter> - switches to that worktree
      -- <c-d> - deletes that worktree
      -- <c-f> - toggles forcing of the next deletion

      keymaps.normal['<space>,w'] = {
        require 'telescope'.extensions.git_worktree.create_git_worktree,
        group = 'Telescope',
        'Create [W]orktree'
      }
    end
  end
}
