vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.shiftwidth = 2
vim.o.undofile = true
-- this is important if you're going to use an application that uses a filewatcher (bundler, cron)
vim.o.backupcopy = "yes"


vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true



vim.g.mapleader = " "
vim.g.localmapleader = "\\"

local bench = require('benchmark')
local end_bench = bench:start_bench('Running plugins')
require("plugins")
end_bench()
end_bench = bench:start_bench('Running utils')
require("utils")
end_bench()

vim.cmd('colorscheme tokyonight-night')
vim.lsp.log.set_level("trace")

-- Uncomment this when we have some performance issue it'll try to exlpain what is happening
-- bench:summarize()
