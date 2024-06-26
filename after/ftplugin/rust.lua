
local bufnr = vim.api.nvim_get_current_buf()
local opts = {
    silent = true,       -- do not show message
    buffer = bufnr,
}

vim.keymap.set( "n", "<leader>r", function() vim.cmd.RustLsp { 'runnables', bang = true } end, opts)
vim.keymap.set( "n", "<leader>ca", function() vim.cmd.RustLsp('codeAction') end, opts)
vim.keymap.set( "n", "<leader>oc", function() vim.cmd.RustLsp('openCargo') end, opts)

vim.keymap.set( "n", "<A-S-j>", function() vim.cmd.RustLsp { 'moveItem', 'down' } end, opts)
vim.keymap.set( "n", "<A-S-k>", function() vim.cmd.RustLsp { 'moveItem', 'up' } end, opts)

vim.keymap.set( "n", "<S-j>", function() vim.cmd.RustLsp('joinLines') end, opts)

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
end, opts)

