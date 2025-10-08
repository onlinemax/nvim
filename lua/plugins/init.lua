-- First install all the plugins
require("plugins.install")

-- I need to find a way to circumvent this else nothing is lazy loaded
for _, spec in ipairs(vim.pack.get()) do
	vim.cmd("packadd " .. spec.spec.name)
end
-- Setup all the plugins
require("plugins.setup")



-- Make sure every plugin is loaded

-- Run TSUpdate when
vim.cmd("TSUpdate")
