return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "rust"
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function(_,_)
      vim.g.rustaceanvim = {
        tools = {
        },
        server = {
          on_attach = function (client, bufnr)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
            vim.keymap.set("n", "<leader>f", function ()
              vim.lsp.buf.format({async = true})
            end, { buffer = bufnr })
          end,
        }
      }
    end
  },

  {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { "BufRead Cargo.toml" },
    config = function()
      require('crates').setup()
    end,
  }
}
