-- Convenience file for all our LSP servers to be used by mason-lspconfig and nvim-lspconfig
-- just so we don't have to define them twice

local M = {}
M.servers = {
    'lua_ls',
    'cssls',
    'html',
    'jsonls',
    'tsserver',
    'pyright',
    'bashls',
    'marksman',
    'yamlls',
    'tailwindcss',
    'ruff_lsp',
    'svelte',
}

return M
