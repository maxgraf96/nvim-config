local M = {
    'nvim-lualine/lualine.nvim',
    lazy = false,
}

M.config = function()
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
        color = { bg = '#19181a', fg = 'grey' },
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
        color = { bg = '#19181a', fg = 'grey' },
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

    -- local custom_monokai = require 'lualine.themes.monokai-pro'
    -- custom_monokai.normal.a.bg = custom_monokai.normal.c.bg
    -- custom_monokai.normal.a.fg = custom_monokai.normal.c.fg

    local function project_n_venv()
        local venv = vim.fn.finddir('venv', vim.fn.getcwd() .. ';')
        local venv_str = ''
        if venv ~= '' then
            venv_str = '  ' .. venv
        end
        local session_name = require('auto-session.lib').current_session_name()
        return session_name .. ' | ' .. venv_str
    end

    lualine.setup {
        options = {
            -- theme = custom_monokai,
            -- theme = 'monokai-pro',
            globalstatus = true, -- only one status line for entire window
            icons_enabled = true,
            section_separators = { left = '|', right = '|' },
            component_separators = { left = '|', right = '|' },
            always_divide_middle = true,
            ignore_focus = {
                'NVimTree',
                'dashboard',
                'Outline',
            },
            disabled_filetypes = {
                'dapui_watches',
                'dapui_breakpoints',
                'dapui_scopes',
                'dapui_console',
                'dapui_stacks',
                'dap-repl',
            },
        },
        sections = {
            lualine_a = { branch, diagnostics },
            lualine_b = { mode },
            lualine_c = { project_n_venv },
            -- lualine_d = { 'filename' },
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

return M
