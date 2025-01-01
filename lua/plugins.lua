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
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x"
    },
    "neovim/nvim-lspconfig",
    "simrat39/rust-tools.nvim",
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- auto-save
    {
        "okuuva/auto-save.nvim",
        version = '^1.0.0', -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
        cmd = "ASToggle", -- optional for lazy loading on command
        event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
        opts = {
            enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
            trigger_events = { -- See :h events
                immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
                defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
            },
            -- function that takes the buffer handle and determines whether to save the current buffer or not
            -- return true: if buffer is ok to be saved
            -- return false: if it's not ok to be saved
            -- if set to `nil` then no specific condition is applied
            condition = nil,
            write_all_buffers = false, -- write all buffers when the current one meets `condition`
            noautocmd = false, -- do not execute autocmds when saving
            lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
            debounce_delay = 3000, -- delay after which a pending save is executed
            -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
            debug = false,
        },
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
    -- co-pilot
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
          require("copilot").setup({
              suggestion = { enabled = false },
              panel = { enabled = false },
          })
      end,
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
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

          local lsp = require("lsp-zero").preset({})
          lsp.extend_lspconfig()

          -- Format on save
          lsp.format_on_save({
              format_opts = {
                  async = false,
                  timeout_ms = 10000,
              },
              servers = {
                  ["rust-analyzer"] = { "rust" },
              }
          })
      end,
    },    
    -- golang
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
          require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        "olexsmir/gopher.nvim",
        dependencies = { -- dependencies
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    -- nvim-telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-telescope/telescope-file-browser.nvim", "nvim-lua/plenary.nvim" }
    }
})

require('lsp-zero')                                                                  
require('lspconfig').intelephense.setup({})

