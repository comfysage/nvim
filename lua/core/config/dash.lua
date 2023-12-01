return {
  setup = function(opts)
    vim.api.nvim_create_user_command('Dash', function()
        require 'core.plugin.dash'.open (opts)
    end, {})
  end
}
