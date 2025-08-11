require("utils.languages")
require("utils.keymaps")

-- This is to format on save
vim.api.nvim_create_autocmd({ "BufWritePre", "BUfWrite" }, {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format()
	end
})

-- Change the diagnostic symbols to icon
local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

for name, icon in pairs(symbols) do
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
