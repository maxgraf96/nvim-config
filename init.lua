-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set the python path - custom venv that we need to create for each machine
-- This one is for windows
vim.g.python3_host_prog = vim.fn.stdpath 'config' .. '/venv/Scripts/python.exe'
-- Todo different on macOS

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'
vim.notify = require 'notify'

-- [[ Basic Keymaps ]]
require 'keymaps'

vim.cmd 'colorscheme monokai-pro'

-- Open nvim-tree
-- vim.cmd 'NvimTreeOpen'

-- Make it so that when I type :qq it write :qa
vim.cmd 'cabbrev qq qa'

require('toggleterm').setup {
    open_mapping = [[<C-\>]],
}

require('Comment').setup()

-- Make search within file wrap around
vim.opt.wrapscan = true

-- Autocommands --
-- Auto select virtualenv for python projects that have a venv folder on Nvim open
vim.api.nvim_create_autocmd('VimEnter', {
    desc = 'Auto select virtualenv Nvim open',
    pattern = '*',
    callback = function()
        local venv = vim.fn.finddir('venv', vim.fn.getcwd() .. ';')
        if venv ~= '' then
            require('venv-selector').retrieve_from_cache()
            -- echo that the venv with the path has been activated
            vim.cmd 'echo "Venv activated."'
        end
    end,
    once = true,
})

-- Close nvim-dap-ui if open before we leave, otherwise it will ruin the auto-session
vim.api.nvim_create_autocmd('VimLeavePre', {
    desc = 'Close nvim-dap-ui if open',
    pattern = '*',
    callback = function(args)
        require('dapui').close()
    end,
    once = true,
})

local dap, dapui = require 'dap', require 'dapui'
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
    -- also hide nvim-tree
    vim.cmd 'NvimTreeClose'
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
    -- also hide nvim-tree
    vim.cmd 'NvimTreeClose'
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
    -- also show nvim-tree
    vim.cmd 'NvimTreeOpen'
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
    -- also show nvim-tree
    vim.cmd 'NvimTreeOpen'
end

-- Scrolling stuff --
require('neoscroll').setup {
    easing_function = 'quadratic',
}
-- replace <ScrollWheelUp> and <ScrollWheelDown> with the function call
-- to neoscroll#scroll
vim.api.nvim_set_keymap('n', '<ScrollWheelUp>', '<cmd>lua require("neoscroll").scroll(-6, true, 40)<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<ScrollWheelDown>', '<cmd>lua require("neoscroll").scroll(6, true, 40)<cr>', { noremap = true, silent = true })

-- IMPORTANT: This needs to point to our nvim python executable that has pydebug installed, not the one in the cwd (unless it also has pydebug installed, which would be silly)
local dap_python_path = vim.fn.stdpath 'config' .. '/venv/Scripts/python.exe'
require('dap-python').setup(dap_python_path)

vim.api.nvim_create_user_command('GCA', function()
    local input = vim.fn.input 'Commit message: '
    -- Escape single quotes in the commit message
    input = input:gsub("'", "'\\''")

    if input == '' then
        print 'Commit aborted: no commit message entered.'
        return
    end

    -- Run git commands using Fugitive
    vim.cmd 'G add .' -- equivalent to 'git add .'
    vim.cmd("G commit -m '" .. input .. "'") -- commit with the provided message
    vim.cmd 'G push' -- push the commit
end, { nargs = 0 })

require('csvlens').setup {
    direction = 'horizontal', -- "float" | "vertical" | "horizontal" |  "tab"
    exec_path = 'csvlens', -- You can specify the path to the executable if you wish. Otherwise, it will use the command in the PATH.
    exec_install_path = vim.fn.stdpath 'data' .. '/csvlens.nvim/', -- directory to install the executable to if it's not found in the exec_path, ends with /
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
