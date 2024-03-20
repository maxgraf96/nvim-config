return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local null_ls = require 'null-ls'

            null_ls.setup {
                sources = {
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.formatting.black,
                },
            }
        end,
    },
    {
        'folke/neodev.nvim',
        opts = {},
        config = function()
            require('neodev').setup {
                library = { plugins = { 'nvim-dap-ui' }, types = true },
            }
        end,
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require 'dap'

            dap.adapters.python = {
                type = 'executable',
                command = 'python',
                args = { '-m', 'debugpy.adapter' },
            }

            dap.configurations.python = {
                {
                    -- The name of the configuration
                    name = 'Launch file',
                    -- Adapter type
                    type = 'python',
                    -- Request type
                    request = 'launch',
                    -- Path to the file to debug
                    program = '${file}',
                    -- Ask for which file to debug if not specified
                    askForFile = true,
                    -- Do not stop at the entry
                    justMyCode = false,
                    args = { '--multiprocess' },
                    subProcess = true,
                    console = 'internalConsole',
                },
            }

            vim.fn.sign_define('DapBreakpoint', {
                text = '🔴',
                texthl = '',
                linehl = '',
                numhl = '',
            })

            -- Key mappings
            -- vim.api.nvim_set_keymap('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", {
            -- noremap = true,
            -- })
            vim.api.nvim_set_keymap('n', '<F10>', "<Cmd>lua require'dap'.step_over()<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<F11>', "<Cmd>lua require'dap'.step_into()<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<F12>', "<Cmd>lua require'dap'.step_out()<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<Leader>db', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<Leader>B', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<Leader>lp', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<Leader>dr', "<Cmd>lua require'dap'.repl.open()<CR>", {
                noremap = true,
            })
            vim.api.nvim_set_keymap('n', '<Leader>dl', "<Cmd>lua require'dap'.run_last()<CR>", {
                noremap = true,
            })
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('dapui').setup {
                -- Set icons to characters that are more likely to work in every terminal.
                --    Feel free to remove or use ones that you like more! :)
                --    Don't feel like these are good choices.
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    icons = {
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            }
            -- Key mappings
            vim.api.nvim_set_keymap('n', '<Leader>dd', "<Cmd>lua require'dapui'.toggle()<CR>", {
                noremap = true,
            })
        end,
    },
}
