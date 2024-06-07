
local bufnr = vim.api.nvim_get_current_buf()
local opts = {
    silent = true,       -- do not show message
    buffer = bufnr,
}

vim.keymap.set( "n", "<leader>ca", function() vim.cmd.RustLsp('codeAction') end, opts)
vim.keymap.set( "n", "<leader>r", function() vim.cmd.RustLsp { 'runnables', bang = true } end, opts)
vim.keymap.set( "n", "<leader>oc", function() vim.cmd.RustLsp('openCargo') end, opts)

