return {
    {
        'gbprod/nord.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nord_contrast = true
            vim.g.nord_borders = false
            vim.g.nord_disable_background = false
            vim.g.nord_italic = false
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = false

            -- require('nord').setup({})
        end,
    },
    {
        'loctvl842/monokai-pro.nvim',
        priority = 1000,
        config = function()
            require('monokai-pro').setup {
                transparent_background = false,
                terminal_colors = true,
                devicons = true, -- highlight the icons of `nvim-web-devicons`
                styles = {
                    comment = { italic = true },
                    keyword = { italic = true }, -- any other keyword
                    type = { italic = true }, -- (preferred) int, long, char, etc
                    storageclass = { italic = true }, -- static, register, volatile, etc
                    structure = { italic = true }, -- struct, union, enum, etc
                    parameter = { italic = true }, -- parameter pass in function
                    annotation = { italic = true },
                    tag_attribute = { italic = true }, -- attribute of tag in reactjs
                },
                filter = 'pro', -- classic | octagon | pro | machine | ristretto | spectrum
                -- Enable this will disable filter option
                day_night = {
                    enable = false, -- turn off by default
                    day_filter = 'pro', -- classic | octagon | pro | machine | ristretto | spectrum
                    night_filter = 'spectrum', -- classic | octagon | pro | machine | ristretto | spectrum
                },
                inc_search = 'background', -- underline | background
                background_clear = {
                    -- "float_win",
                    'toggleterm',
                    'telescope',
                    'which-key',
                    'renamer',
                    'notify',
                    'nvim-tree',
                    -- "neo-tree",
                    'bufferline', -- better used if background of `neo-tree` or `nvim-tree` is cleared
                }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
                plugins = {
                    bufferline = {
                        underline_selected = false,
                        underline_visible = false,
                    },
                    indent_blankline = {
                        context_highlight = 'default', -- default | pro
                        context_start_underline = false,
                    },
                },
                overrideScheme = function(cs, p, config, hp)
                    local cs_override = {}
                    local calc_bg = hp.blend(p.background, 0.85, '#000000')

                    cs_override.editor = {
                        background = calc_bg,
                    }
                    return cs_override
                end,
            }
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000, -- make sure to load this before all the other start plugins
    },
}
