return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require 'custom.plugins.toggleterm'

        local powershell_options = {
            shell = vim.fn.executable 'pwsh' == 1 and 'pwsh' or 'powershell',
            shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
            shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
            shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
            shellquote = '',
            shellxquote = '',
        }

        for option, value in pairs(powershell_options) do
            vim.opt[option] = value
        end

        require('toggleterm').setup {
            on_create = function(term)
                local venv = vim.fn.finddir('venv', vim.fn.getcwd() .. ';')
                if venv ~= '' then
                    -- Use vim.cmd to execute Vim commands
                    -- Using :send to send the command 'sact' to the terminal
                    -- The <CR> simulates pressing Enter after the command
                    vim.cmd(string.format("call jobsend(%d, 'sact')", term.job_id))
                    -- add <CR>
                    vim.cmd(string.format('call jobsend(%d, "\\<CR>")', term.job_id))
                end
            end,
        }
    end,
}
