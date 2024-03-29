local M = {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
}

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap
    keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    local status_ok, mason = pcall(require, 'mason')
    if not status_ok then
        return
    end
    mason.on_attach(client, bufnr)
end

M.common_capabilities = function()
    local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if status_ok then
        return cmp_nvim_lsp.default_capabilities()
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { 'documentation', 'detail', 'additionalTextEdits' },
    }
    return capabilities
end

M.toggle_inlay_hints = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

function M.config()
    -- We set these here and not in keymaps.lua because we don't want to use LSP keymaps in non-LSP buffers
    local wk = require 'which-key'
    wk.register {
        ['<leader>la'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
        ['<leader>lf'] = {
            "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
            'Format',
        },
        ['<leader>li'] = { '<cmd>LspInfo<cr>', 'Info' },
        ['<leader>lj'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next Diagnostic' },
        ['<leader>lh'] = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", 'Hints' },
        ['<leader>lk'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Prev Diagnostic' },
        ['<leader>ll'] = { '<cmd>lua vim.lsp.codelens.run()<cr>', 'CodeLens Action' },
        ['<leader>lq'] = { '<cmd>lua vim.diagnostic.setloclist()<cr>', 'Quickfix' },
        ['<leader>lr'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
    }

    wk.register {
        ['<leader>la'] = {
            name = 'LSP',
            a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action', mode = 'v' },
        },
    }

    local lspconfig = require 'lspconfig'
    local icons = require 'user.icons'

    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
                { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
                { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
                { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    }

    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
    require('lspconfig.ui.windows').default_options.border = 'rounded'

    -- Fetching servers from user.lsp-servers here
    local servers = require('user.lsp-servers').servers
    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        -- Check if we have custom settings for the server

        local require_ok, settings = pcall(require, 'custom.plugins.lsp.lspsettings.' .. server)
        if require_ok then
            opts = vim.tbl_deep_extend('force', settings, opts)
        end

        -- Other server specific options will go here...
        --
        --
        if server == 'ruff_lsp' then
            -- Disable hover in favor of Pyright
            opts.capabilities.hoverProvider = false
        end

        -- vim.cmd('echom "Setting up LSP server for ' .. server .. '"')

        if server == 'svelte' then
            vim.cmd [[echo "Svelte LSP is enabled"]]
            opts.filetypes = { 'typescript', 'javascript', 'svelte', 'html', 'css' }
            opts.on_attach = function(client)
                vim.api.nvim_create_autocmd('BufWritePost', {
                    pattern = { '*.js', '*.ts' },
                    callback = function(ctx)
                        client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
                    end,
                })
                vim.api.nvim_create_autocmd({ 'BufWrite' }, {
                    pattern = { '+page.server.ts', '+page.ts', '+layout.server.ts', '+layout.ts' },
                    command = 'LspRestart svelte',
                })
            end

            -- Additionally, disable tsserver for svelte files
            lspconfig.tsserver.setup {
                on_attach = function(client)
                    client.resolved_capabilities.document_formatting = false
                    client.resolved_capabilities.document_range_formatting = false
                end,
            }
        end

        lspconfig[server].setup(opts)
    end
end

return M
