-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "csharp_ls", "slint_lsp", "roslyn" }
vim.lsp.enable(servers)
vim.lsp.inlay_hint.enable()
