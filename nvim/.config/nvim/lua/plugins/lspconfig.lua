return {
    'neovim/nvim-lspconfig',
    config = function()
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)

                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
                end

                client.server_capabilities.semanticTokensProvider = nil

                if client.name == "rust_analyzer" and client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
                        buffer = ev.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = ev.buf })
                        end,
                    })
                end
            end,
        })
    end
}