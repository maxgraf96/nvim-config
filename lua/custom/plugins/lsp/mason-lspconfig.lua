local M = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
}

function M.config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup {
        ui = {
            border = 'rounded',
        },
    }

    require('mason-lspconfig').setup {
        -- Fetching servers from user.lsp-servers here
        ensure_installed = require('user.lsp-servers').servers,
    }
end

return M
