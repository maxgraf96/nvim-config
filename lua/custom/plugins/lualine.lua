local lualine_config = function()
    local lualine = require 'lualine'

    local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn' },
        symbols = { error = ' ', warn = ' ' },
        colored = false,
        update_in_insert = false,
        always_visible = true,
    }

    local diff = {
        'diff',
        colored = false,
        symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
        cond = hide_in_width,
    }

    local mode = {
        'mode',
        fmt = function(str)
            return '-- ' .. str .. ' --'
        end,
    }

    local filetype = {
        'filetype',
        colored = true, -- Displays filetype icon in color if set to true
        icon_only = false, -- Display only an icon for filetype
        icon = { align = 'right' }, -- Display filetype icon on the right hand side
    }

    local branch = {
        'branch',
        icons_enabled = true,
        icon = '',
    }

    local location = {
        'location',
        padding = 0,
    }

    -- cool function for progress
    local progress = function()
        local current_line = vim.fn.line '.'
        local total_lines = vim.fn.line '$'
        local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end

    local spaces = function()
        return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
    end

    local custom_monokai = require 'lualine.themes.monokai-pro'
    custom_monokai.normal.a.bg = custom_monokai.normal.c.bg
    custom_monokai.normal.a.fg = custom_monokai.normal.c.fg

    lualine.setup {
        options = {
            theme = custom_monokai,
            -- theme = 'monokai-pro',
            icons_enabled = true,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            -- component_separators = { left = '', right = '' },
            -- section_separators = { left = '', right = '' },
            disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline' },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { branch, diagnostics },
            lualine_b = { mode },
            lualine_c = { require('auto-session.lib').current_session_name },
            lualine_d = { 'filename' },
            lualine_x = { diff, spaces, 'encoding', filetype },
            lualine_y = { location },
            lualine_z = { progress },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    }
end

return {
    {
        'nvim-lualine/lualine.nvim',
        config = lualine_config,
    },
}
