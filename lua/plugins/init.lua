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
        "html", "css", "rust",
        "c_sharp", "slint"
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function(_,_)
      local codelldb = vim.fn.expand "$MASON/packages/codelldb"
      local extension_path = codelldb .. '/extension/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb'
      local this_os = vim.loop.os_uname().sysname

      -- windows fixes
      if string.sub(this_os, 1, 7) == 'Windows' then
        extension_path = codelldb .. '\\extension\\'
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
      else
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
      end

      local cfg = require('rustaceanvim.config')
      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        tools = {
        },
        server = {
          on_attach = function (_, bufnr)
            vim.keymap.set("n", "grt", "<cmd>RustLsp testables<cr>", {buffer = bufnr})
            vim.keymap.set('n', '<Leader>a', '<Plug>RustHoverAction')
            vim.keymap.set('n', '<Leader>mj', '<cmd>RustLsp moveItem down<cr>')
            vim.keymap.set('n', '<Leader>mk', '<cmd>RustLsp moveItem up<cr>')
            vim.keymap.set('n', ']r', '<cmd>RustLsp relatedDiagnostics<cr>')
            vim.keymap.set('n', '<Leader>.', '<cmd>RustLsp codeAction<cr>')
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
      require('crates').setup {
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- the same on_attach function as for your other language servers
            -- can be ommited if you're using the `LspAttach` autocmd
          end,
          actions = true,
          completion = true,
          hover = true,
        },
        --completion = {
        --  cmp = {
        --    enabled = true
        --  },
        --},
      }
      require("cmp").setup.buffer({
        sources = { { name = "crates" } }
      })
    end,
  },

  {
    'mfussenegger/nvim-dap',
    config = function ()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function ()
        dapui.close()
      end
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require('rustaceanvim.neotest')
        },
    }
    end,
  },
}
