require("create_lazy")

vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.ignorecase = true
vim.o.shiftwidth = 2


vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.mapleader = " "
vim.g.localmapleader = "\\"

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "tokyonight-storm" } },
	checker = { enabled = true },
})



require("utils")

vim.cmd('colorscheme tokyonight-storm')
