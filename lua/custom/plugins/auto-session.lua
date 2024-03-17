local function restore_nvim_tree()
    local nvim_tree = require('nvim-tree')
    nvim_tree.change_dir(vim.fn.getcwd())
    -- toggle nvim_tree (:NvimTreeToggle)
    vim.cmd 'NvimTreeOpen'
end

return {
    'rmagatti/auto-session',
    config = function()

        require('auto-session').setup {
            log_level = 'error',
            auto_save_enabled = true,
            -- auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },

            post_restore_cmds = { restore_nvim_tree },

            cwd_change_handling = {
                post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
                  require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
                end,
              },

            session_lens = {
                -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
              },
        }
    end,
}

