-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank()
	end,
})
