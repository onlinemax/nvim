vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.shiftwidth = 2
vim.o.undofile = true


vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true



vim.g.mapleader = " "
vim.g.localmapleader = "\\"


require("plugins")
require("utils")

vim.cmd('colorscheme tokyonight-night')
