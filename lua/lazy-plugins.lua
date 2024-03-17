-- [[ Configure and install plugins ]]

require('lazy').setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- modular approach: using `require 'path/name'` will
    -- include a plugin definition from file lua/path/name.lua

    require 'kickstart/plugins/which-key',

    require 'kickstart/plugins/telescope',

    require 'kickstart/plugins/conform',

    require 'kickstart/plugins/todo-comments',

    -- Import all our plugins
    { import = 'custom.plugins' },
    { import = 'custom.plugins.lsp' },
}, {
    ui = {
        -- If you have a Nerd Font, set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            -- cmd = '⌘',
            -- config = '🛠',
            -- event = '📅',
            -- ft = '📂',
            -- init = '⚙',
            -- keys = '🗝',
            -- plugin = '🔌',
            -- runtime = '💻',
            -- require = '🌙',
            -- source = '📄',
            -- start = '🚀',
            -- task = '📌',
            -- lazy = '💤 ',
        },
    },
})

-- vim: ts=2 sts=2 sw=2 et
