--[[

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not sure exactly what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or neovim features used in kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your nvim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info

I hope you enjoy your Neovim journey,
- TJ
--]]

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

-- Position the cursor in the main buffer, not in nvim-tree
-- For us that's just ctrl+l

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
