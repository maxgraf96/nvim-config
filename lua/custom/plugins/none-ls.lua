local M = {
    'nvimtools/none-ls.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
}

function M.config()
    local null_ls = require 'null-ls'

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup {
        debug = false,
        sources = {
            -- Formatting
            formatting.stylua,
            formatting.prettierd.with {
                filetypes = { 'html', 'javascript', 'typescript', 'json', 'yaml', 'css', 'svelte' },
                extra_filetypes = { 'svelte' },
                extra_args = { '--print-width', '100', '--single-attribute-per-line', 'false' },
            },
            formatting.black,
            -- formatting.eslint,
            -- Diagnostics
            -- null_ls.builtins.diagnostics.mypy,
            -- diagnostics.flake8,
            null_ls.builtins.completion.spell,
        },
        -- configure format on save
        on_attach = function(current_client, bufnr)
            if current_client.supports_method 'textDocument/formatting' then
                vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format {
                            filter = function(client)
                                --  only use null-ls for formatting instead of lsp server
                                return client.name == 'null-ls'
                            end,
                            bufnr = bufnr,
                        }
                    end,
                })
            end
        end,
    }
end

return M
