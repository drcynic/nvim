local bufnr = vim.api.nvim_get_current_buf()
local opts = {
    -- silent = true,       -- do not show message
    buffer = bufnr,
}

vim.keymap.set("n", "<leader>r", ":GoRun . -F -a testdata2/<CR>i", opts)

