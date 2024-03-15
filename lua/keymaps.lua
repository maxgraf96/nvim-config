-- [[ local status_ok, wk = pcall(require, "which-key") ]]
local wk = require("which-key")

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("", "<C-h>", "<Nop>", opts)
keymap("", "<C-j>", "<Nop>", opts)
keymap("", "<C-k>", "<Nop>", opts)
keymap("", "<C-l>", "<Nop>", opts)
wk.register({
  name = "Window navigation",
  -- ["<C-h>"] = { "<C-w>h", "Left" },
  -- ["<C-j>"] = { "<C-w>j", "Down" },
  -- ["<C-k>"] = { "<C-w>k", "Up" },
  -- ["<C-l>"] = { "<C-w>l", "Right" },
  ["<C-h>"] = { "<CMD>NavigatorLeft<CR>", "Left" },
  ["<C-j>"] = { "<CMD>NavigatorDown<CR>", "Down" },
  ["<C-k>"] = { "<CMD>NavigatorUp<CR>", "Up" },
  ["<C-l>"] = { "<CMD>NavigatorRight<CR>", "Right" },
  ["<S-Up>"] = { ":resize +2<CR>", "Increase height" },
  ["<S-Down>"] = { ":resize -2<CR>", "Decrease height" },
  ["<S-Left>"] = { ":vertical resize -2<CR>", "Decrease width" },
  ["<S-Right>"] = { ":vertical resize +2<CR>", "Increase width" },
  ["<S-l>"] = { ":bnext<CR>", "Next buffer" },
  ["<S-h>"] = { ":bprevious<CR>", "Previous buffer" },
}, {
  mode = "n",
  silent = true,
  noremap = true,
})



-- Telescope
wk.register({
  name = "Telescope",
  ["<leader>"] = {
    f = {
      "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
      "Find files",
    },
    s = {
      "<cmd>lua require'telescope.builtin'.lsp_document_symbols(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
      "Find symbols",
    },
    t = { "<cmd>Telescope<cr>", "Open Telescope" },
    -- d = { "<cmd>Telescope diagnostics<cr>", "Open diagnostics for current project" },
    b = {
      "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
      "List current buffers",
    },
    [","] = {
      "<cmd>lua require'telescope.builtin'.command_history(require('telescope.themes').get_dropdown({previewer = true}))<cr>",
      "Open command history",
    },
  },
}, {
  mode = "n",
  silent = true,
  noremap = true,
})
wk.register({
  name = "Telescope",
  ["<C-t>"] = { "<cmd>Telescope live_grep<cr>", "Find text in project" },
}, {
  mode = "n",
  silent = true,
  noremap = true,
})

-- NvimTree
wk.register({
  name = "NvimTree",
  ["<leader>"] = {
    e = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" },
  },
}, {
  mode = "n",
  silent = true,
  noremap = true,
})


-- Trouble
wk.register({
  name = "Trouble",
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Location list" },
  },
  ["g"] = {
    d = { "<cmd>TroubleToggle lsp_definitions<cr>", "Show definitions" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "Show references" },
  },
})

-- zen mode
wk.register({
  ["<leader>"] = {
    z = { "<cmd>ZenMode<cr>", "Toggle zen mode" },
  },
})


-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

-- My commands

-- nvim-tree


-- vim: ts=2 sts=2 sw=2 et
