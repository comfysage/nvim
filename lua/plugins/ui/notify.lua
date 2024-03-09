return {
  'j-hui/fidget.nvim', event = 'UIEnter',
  opts = {
    notification = {
      override_vim_notify = true,
      filter = vim.log.levels.DEBUG,
      configs = {
        default = {
          name = "Notifications",
          icon = "",
          ttl = 4,
          group_style = "Title",
          icon_style = "Special",
          annote_style = "Question",
          debug_style = "Comment",
          info_style = "Question",
          warn_style = "WarningMsg",
          error_style = "ErrorMsg",
          debug_annote = "DEBUG",
          info_annote = "INFO",
          warn_annote = "WARN",
          error_annote = "ERROR",
        },
      },
      window = {
        winblend = 0,
      },
    },
  },
  config = function (_, opts)
    require 'fidget'.setup (opts)

    core.config.log_level = vim.env['DEV'] and vim.log.levels.DEBUG or vim.log.levels.INFO
  end
}
