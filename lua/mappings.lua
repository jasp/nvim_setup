require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "grn", function ()
  vim.lsp.buf.rename()
end)

map("n", "gra", function ()
  vim.lsp.buf.code_action()
end)

map("n", "grr", function ()
  vim.lsp.buf.references()
end)
