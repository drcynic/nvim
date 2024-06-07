local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- color schemes
    "catppuccin/nvim",
    "tanvirtin/monokai.nvim",
    "joshdick/onedark.vim",
    "folke/tokyonight.nvim",
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- tabs (barbar)
    {
        "romgrk/barbar.nvim",
        dependencies = {
          "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
          "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
    },
    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "simrat39/rust-tools.nvim",
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer", -- buffer auto-completion
            "hrsh7th/cmp-path", -- path auto-completion
            "hrsh7th/cmp-cmdline", -- cmdline auto-completion
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },
    -- Rust
    "rust-lang/rust.vim",
    {
      'mrcjkb/rustaceanvim',
      version = '^4', -- Recommended
      lazy = false, -- This plugin is already lazy
      ft = { "rust" },
      opts = {
          server = {
              on_attach = function(client, bufnr)
              -- you can also put keymaps in here
              end,
              default_settings = {
                  -- rust-analyzer language server configuration
                  ['rust-analyzer'] = {
                  },
              },
          },
      },
      config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
      end,
    },    
    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    -- nvim-telescope
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
 })

