require("utils.languages")
require("utils.keymaps")
require("utils.yank")
require("utils.dapconfig")

-- Change the diagnostic symbols to icon
local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

local diagnostic_config = {
	virtual_text = true,
	float = { border = 'rounded' },
	signs = { text = {} },
};

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
