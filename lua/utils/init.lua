require("utils.languages")
require("utils.keymaps")
require("utils.yank")
require("utils.dapconfig")

local format_on_save = true
vim.keymap.set('n', '<leader>of', function()
	format_on_save = not format_on_save
end, { desc = '[O] ption [F]ormat on save' })
-- This is to format on save
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWrite" }, {
	pattern = "*",
	callback = function()
		local clients = vim.lsp.get_clients()
		for _, client in ipairs(clients) do
			if client:supports_method("textDocument/formatting", vim.api.nvim_get_current_buf()) and format_on_save then
				vim.lsp.buf.format()
			end
		end
	end
})

-- Change the diagnostic symbols to icon
local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }
local diagnostic_config = { signs = { text = {} } };

for name, icon in pairs(symbols) do
	diagnostic_config.signs.text[vim.diagnostic.severity[string.upper(name)]] = icon;
end
vim.diagnostic.config(diagnostic_config);

-- Open markdown viewer
vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

--Recognize tpp files as cpp files
vim.filetype.add({
	extension = { tpp = "cpp" }
})
