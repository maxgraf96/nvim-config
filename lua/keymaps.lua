-- [[ local status_ok, wk = pcall(require, "which-key") ]]
local wk = require 'which-key'

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better window navigation
keymap('', '<C-h>', '<Nop>', opts)
keymap('', '<C-j>', '<Nop>', opts)
keymap('', '<C-k>', '<Nop>', opts)
keymap('n', '<C-l>', '<Nop>', opts)
wk.register({
    name = 'Window navigation',
    ['<C-h>'] = { '<CMD>NavigatorLeft<CR>', 'Left' },
    ['<C-j>'] = { '<CMD>NavigatorDown<CR>', 'Down' },
    ['<C-k>'] = { '<CMD>NavigatorUp<CR>', 'Up' },
    ['<C-l>'] = { '<CMD>NavigatorRight<CR>', 'Right' },
    ['<S-Up>'] = { ':resize +2<CR>', 'Increase height' },
    ['<S-Down>'] = { ':resize -2<CR>', 'Decrease height' },
    ['<S-Left>'] = { ':vertical resize -2<CR>', 'Decrease width' },
    ['<S-Right>'] = { ':vertical resize +2<CR>', 'Increase width' },
    ['<S-l>'] = { ':bnext<CR>', 'Next buffer' },
    ['<S-h>'] = { ':bprevious<CR>', 'Previous buffer' },
}, {
    mode = 'n',
    silent = true,
    noremap = true,
})

-- Telescope
wk.register({
    name = 'Telescope',
    ['<leader>'] = {
        f = {
            "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
            'Find files',
        },
        s = {
            "<cmd>lua require'telescope.builtin'.lsp_document_symbols(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
            'Find symbols',
        },
        t = { '<cmd>Telescope<cr>', 'Open Telescope' },
        -- d = { "<cmd>Telescope diagnostics<cr>", "Open diagnostics for current project" },
        b = {
            "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
            'List current buffers',
        },
        [','] = {
            "<cmd>lua require'telescope.builtin'.command_history(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
            'Open command history',
        },
        p = {
            '<cmd>Telescope project<cr>',
            'Open projects',
        },
    },
}, {
    mode = 'n',
    silent = true,
    noremap = true,
})
wk.register({
    name = 'Telescope',
    ['<C-t>'] = { '<cmd>Telescope live_grep<cr>', 'Find text in project' },
}, {
    mode = 'n',
    silent = true,
    noremap = true,
})

-- NvimTree
wk.register({
    name = 'NvimTree',
    ['<leader>'] = {
        e = { '<cmd>NvimTreeToggle<cr>', 'Toggle NvimTree' },
    },
}, {
    mode = 'n',
    silent = true,
    noremap = true,
})

-- Trouble
wk.register {
    name = 'Trouble',
    ['<leader>x'] = {
        name = 'Trouble',
        x = { '<cmd>TroubleToggle<cr>', 'Toggle trouble' },
        w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Workspace diagnostics' },
        d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Document diagnostics' },
        q = { '<cmd>TroubleToggle quickfix<cr>', 'Quickfix' },
        l = { '<cmd>TroubleToggle loclist<cr>', 'Location list' },
    },
    ['g'] = {
        d = { '<cmd>TroubleToggle lsp_definitions<cr>', 'Show definitions' },
        r = { '<cmd>TroubleToggle lsp_references<cr>', 'Show references' },
    },
}

-- zen mode
wk.register {
    ['<leader>'] = {
        z = { '<cmd>ZenMode<cr>', 'Toggle zen mode' },
    },
}

-- [[ Basic Keymaps ]]

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- ctrl+s to save
keymap('n', '<C-s>', '<cmd>w<cr>', opts)

wk.register({
    ['<leader>h'] = { '<cmd>Bdelete<cr>', 'Close Buffer' },
}, {
    mode = 'n',
    silent = true,
    noremap = true,
})

keymap('i', '<C-s>', '<Esc>:w<CR>', opts)

-- Move current line on up with Alt+Shift+k
keymap('n', '<A-S-k>', ':m .-2<CR>==', { noremap = true, silent = true })

-- Move current line on down with Alt+Shift+j
keymap('n', '<A-S-j>', ':m .+2<CR>==', { noremap = true, silent = true })

-- Comment current line with line comment with Ctrl+Shift+c
keymap('n', '<C-a>', ':lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })

-- Ctrl+x to cut current line
keymap('n', '<C-x>', 'dd', opts)

-- leader g A to add all files to git
wk.register {
    ['<leader>gA'] = { '<cmd>Git add %:p:h<cr>', 'Add all files' },
}
-- leader g P to push
wk.register {
    ['<leader>gP'] = { '<cmd>Git push<cr>', 'Push' },
}

-- Ctrl + u undoes the last action in insert mode
keymap('i', '<C-u>', '<Nop>', opts)
vim.api.nvim_set_keymap('i', '<C-u>', '<C-g>u<Esc>u<Insert>', { noremap = true })
-- Ctrl + h and Ctrl + l to move one entire word forward and backward in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<S-Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<S-Right>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-w>', '<cmd>Bdelete<cr>', { noremap = true, silent = true })
-- vim: ts=2 sts=2 sw=2 et
--
