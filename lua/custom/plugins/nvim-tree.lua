return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup {
            update_focused_file = {
                enable = false,
                update_root = true,
            },
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
        }
    end,
}
