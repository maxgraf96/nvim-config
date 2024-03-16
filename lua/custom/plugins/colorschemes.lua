return {
    {
        "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nord_contrast = true
            vim.g.nord_borders = false
            vim.g.nord_disable_background = false
            vim.g.nord_italic = false
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = false

            require('nord').setup({})
        end
    },
    { 
		"tanvirtin/monokai.nvim",
		priority = 1000,
        config = function()
            -- require('monokai').setup { palette = require('monokai').ristretto }
        end
	},
    { 
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
    	'folke/tokyonight.nvim',
    	priority = 1000, -- make sure to load this before all the other start plugins
  	},
}