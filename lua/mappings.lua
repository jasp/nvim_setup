require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "grn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "gra", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "grr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Show implementations" })
map("n", "<leader>f", function ()
  vim.lsp.buf.format({async = true})
end)

-- Debugger commands
-- yoink from here: https://github.com/letsgetrusty/neovim-rust/blob/main/lua/mappings.lua
local dap = require('dap')
map("n", "<Leader>dl", dap.step_into, { desc = "Debugger step into" })
map("n", "<Leader>dj", dap.step_over, { desc = "Debugger step over" })
map("n", "<Leader>dk", dap.step_out, { desc = "Debugger step out" })
map("n", "<Leader>dc", dap.continue, { desc = "Debugger continue" })
map("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Debugger tobble breakpoint" })
map("n",
  "<Leader>dd",
  function ()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end,
  { desc = "Debugger set conditional breakpoint"}
)
map("n", "<Leader>de", dap.terminate, { desc = "Debugger reset" })
map("n", "<Leader>dr", dap.run_last, { desc = "Debugger run last" })

map("n", "<Leader>gn", "<cmd>Gitsigns next_hunk<CR>")
map("n", "<Leader>ga", "<cmd>Gitsigns stage_hunk<CR>")
map("n", "<Leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>")
map("n", "<Leader>gp", "<cmd>Gitsigns preview_hunk<CR>")

map("v", "<Leader>d", ":t-<CR>", { desc = "Duplicate selection" })

map("n", "<Leader>tr", require("neotest").run.run, { desc = "Run current test" })
map("n", "<Leader>ta", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run all tests in current file" })
map("n", "<Leader>ts", require("neotest").summary.open, { desc = "Show test summary" })
map("n", "<Leader>tc", require("neotest").summary.close, { desc = "Hide test summary" })
